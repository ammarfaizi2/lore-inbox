Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTCEVeJ>; Wed, 5 Mar 2003 16:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTCEVeJ>; Wed, 5 Mar 2003 16:34:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:46769 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263215AbTCEVeE>; Wed, 5 Mar 2003 16:34:04 -0500
Date: Wed, 05 Mar 2003 13:34:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Gerrit Huizenga <gh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: High Mem Options 
Message-ID: <655220000.1046900062@flay>
In-Reply-To: <E18qgAh-00033w-00@w-gerrit2>
References: <E18qgAh-00033w-00@w-gerrit2>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, if you are referring to a number from me, that was with 2.4 and
> that number seemed high to me at the time.  I don't believe that 10%
> *should* be the amount of degradation.  But I don't have current numbers
> (that I can share, anyway ;-) that prove anything less than that.
> 
> I expect that we'll be diving into this more over the next few months
> as we can generate some large workloads and find the cause of the
> degradation (and hopefully minimize it).

Would also be useful to measure the overhead on a machine with < 4Gb
of RAM ... otherwise you have two effects to deal with:

1. the PAE overhead.
2. The increase in RAM - more data to manage, and potential bounce-buffers.

M.

