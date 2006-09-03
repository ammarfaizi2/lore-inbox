Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWICRsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWICRsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 13:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWICRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 13:48:50 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:28120 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751577AbWICRst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 13:48:49 -0400
Date: Sun, 3 Sep 2006 19:42:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
 Filesystem
In-Reply-To: <20060901172310.GA2622@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609031941210.12800@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
 <20060901115327.80554494.sfr@canb.auug.org.au> <20060901172310.GA2622@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > This set of patches constitutes Unionfs version 2.0. We are presenting it to
>> > be reviewed and considered for inclusion into the kernel.
>> 
>> Small nit: is it possible to order these patches so that the kernel
>> builds at each intermediate point (so we can use git bisect).  The
>> easiest way to achieve this would be to do the Kconfig and Makefile
>> updates last.
>
>Ideally, when Unionfs is commited into git, the whole thing would be one
>commit - what's the point of having half of a filesystem?

So that you can eliminate e.g. locking bugs by searching in less code.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
