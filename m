Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289546AbSAOMtl>; Tue, 15 Jan 2002 07:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289548AbSAOMtb>; Tue, 15 Jan 2002 07:49:31 -0500
Received: from ns.suse.de ([213.95.15.193]:56331 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289546AbSAOMtZ>;
	Tue, 15 Jan 2002 07:49:25 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, kern0201@siscom.net
Subject: Re: Significant Slowdown Occuring in 2.2 starting with 19pre2
In-Reply-To: <200201150402.XAA08887@leros.siscom.net.suse.lists.linux.kernel> <E16QSuJ-0004y1-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jan 2002 13:49:16 +0100
In-Reply-To: Alan Cox's message of "15 Jan 2002 13:39:58 +0100"
Message-ID: <p733d17kcdv.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> The only change in 2.2.19pre2 is the merge of Andrea Arcangeli's VM. Please
> talk to Andrea and see if he can work out why

Also the merge of blkdev-in-pagecache. If the magneto optical disk
has a weird blocksize < PAGE_CACHE_SIZE (doesn't it have 2k normally?) 
then there could be problems.

-Andi
