Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284497AbRLRShn>; Tue, 18 Dec 2001 13:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLRShi>; Tue, 18 Dec 2001 13:37:38 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:9968 "EHLO outside")
	by vger.kernel.org with ESMTP id <S284467AbRLRSgk>;
	Tue, 18 Dec 2001 13:36:40 -0500
Date: Tue, 18 Dec 2001 10:35:47 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: degger@fhm.edu
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
Message-ID: <20011218103547.B1176@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <E16GKvk-0007Sc-00@the-village.bc.nu> <20011218164152.1E4835A3E@Nicole.fhm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218164152.1E4835A3E@Nicole.fhm.edu>; from degger@fhm.edu on Tue, Dec 18, 2001 at 04:34:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 04:34:57PM +0100, degger@fhm.edu wrote:
> What about a CONFIG_8WAY which, if set, activates a scheduler that
> performs better on such nontypical machines?

I'm pretty sure that we can create a scheduler that works well on
an 8-way, and works just as well as the current scheduler on a UP
machine.  There is already a CONFIG_SMP which is all that should
be necessary to distinguish between the two.

What may be of more concern is support for different architectures
such as HMT and NUMA.  What about better scheduler support for
people working in the RT embedded space?  Each of these seem to
have different scheduling requirements.  Do people working on these
'non-typical' machines need to create their own scheduler patches?
OR is there some 'clean' way to incorporate them into the source
tree?

-- 
Mike
