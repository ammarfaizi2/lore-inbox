Return-Path: <linux-kernel-owner+w=401wt.eu-S1422760AbWLPXAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbWLPXAH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWLPXAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:00:07 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3544 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422758AbWLPXAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:00:05 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc1
Date: Sat, 16 Dec 2006 23:00:17 +0000
User-Agent: KMail/1.9.5
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612150141.09020.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612162300.17151.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 December 2006 21:36, Linus Torvalds wrote:
> On Fri, 15 Dec 2006, Alistair John Strachan wrote:
> > In total isolation, v2.6.19..0e75f9063f5c55fb0b0b546a7c356f8ec186825e it
> > breaks. Reverting just 0e75f9063f5c55fb0b0b546a7c356f8ec186825e, it works
> > again.
> >
> > So I think this is the source, but I can't explain why it "goes away"
> > before git1 and "comes back" before 2.6.20-rc1.
>
> Can you see if the kernel state at commit 77d172ce ("[PATCH] fix SG_IO bio
> leak") is good? Ie just do something like
>
> 	git checkout -b test-branch 77d172ce
>
> and compile and test that?

As predicted, it still doesn't work.

[alistair] 22:59 [~/linux-git] git-status
# On branch refs/heads/test-branch
nothing to commit

[root] 22:59 [~] hddtemp /dev/sda
/dev/sda: ATA WDC WD2500KS-00M: S.M.A.R.T. not available

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
