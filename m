Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbTBMLA0>; Thu, 13 Feb 2003 06:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbTBMLAZ>; Thu, 13 Feb 2003 06:00:25 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:34289 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S268021AbTBMLAZ>; Thu, 13 Feb 2003 06:00:25 -0500
Date: Thu, 13 Feb 2003 03:08:32 -0800
From: Chris Wright <chris@wirex.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030213030832.E26339@figure1.int.wirex.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302101655.LAA08303@moss-shockers.ncsc.mil> <20030211080538.A5876@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030211080538.A5876@infradead.org>; from hch@infradead.org on Tue, Feb 11, 2003 at 08:05:38AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig (hch@infradead.org) wrote:
> 
> And that for examples is a very important and needed change.  Security
> modules as loadable modules are a bad idea as you don't have a consistand
> labelling state - just look at the older selinux versions with all the
> precondition mess.  But it should be generalized to a new initcall level
> instead of the current explicit call to the selinux routine..

I wrote such a patch last summer.  I'll rebase it to current and post it
(most likely when i return from .se).  It needs to be separte from
normal initcalls since they all happen too late.
-chris
