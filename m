Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUD1H3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUD1H3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbUD1H3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:29:21 -0400
Received: from web90007.mail.scd.yahoo.com ([66.218.94.65]:5281 "HELO
	web90007.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264670AbUD1H3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:29:19 -0400
Message-ID: <20040428072918.56419.qmail@web90007.mail.scd.yahoo.com>
Date: Wed, 28 Apr 2004 00:29:18 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
To: Andrew Morton <akpm@osdl.org>, busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040427230203.1e4693ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you guys could please either cc or keep this on the
mailing list I would greatly appreciate it.  I am
currently planning to deploy a dual Xeon FS with
2.6.5+akpm-mm6 and would like to know what the issue
is that Brent is seeing.

Thanks!

--- Andrew Morton <akpm@osdl.org> wrote:
> Brent Cook <busterbcook@yahoo.com> wrote:
> >
> >   Running any kernel from the 2.6.6-rc* series
> (and a few previous
> >  -mm*'s),
> 
> It's a shame this wasn't reported earlier.
> 
> > the pdflush process starts using near 100% CPU
> indefinitely after
> >  a few minutes of initial NFS traffic, as far as I
> can tell.
> 
> Please confirm that the problem is observed on the
> NFS client and not the
> NFS server?  I'll assume the client.
> 
> What other filesystems are in use on the client?
> 
> Please describe the NFS mount options and the number
> of CPUs and the amount
> of memory in the machine.  And please send me your
> .config, off-list.
> 
> Thanks.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
