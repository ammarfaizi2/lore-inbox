Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSGWO77>; Tue, 23 Jul 2002 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318081AbSGWO77>; Tue, 23 Jul 2002 10:59:59 -0400
Received: from [195.223.140.120] ([195.223.140.120]:27515 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318080AbSGWO77>; Tue, 23 Jul 2002 10:59:59 -0400
Date: Tue, 23 Jul 2002 17:03:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Tobias Ringstrom <tori@ringstrom.mine.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2aa1
Message-ID: <20020723150344.GN1116@dualathlon.random>
References: <Pine.LNX.4.44.0207181212180.21840-100000@boris.prodako.se> <Pine.LNX.4.44.0207181530390.3911-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181530390.3911-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 03:34:51PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Thu, 18 Jul 2002, Tobias Ringstrom wrote:
> > Why are you not changing the EXTRAVERSION in your patch?  I would make it 
> > much easier to diffrentiate between kernels.
> 
> I did that for me.
> 
> # uname -r
> 2.4.19-rc2-aa1
> # 
> 
> It's working fine for some hours now. The EXTRAVERSION is the only thing 
> that I changed, and -rc2-aa1 works just fine. But my bdflush seems - with 
> the same values as from -rc1-aa2 - not to have 100% of the old efficiency 
> any more.

I guess it's your userspace workload that changed, there are no
bdflush/vm/blkdev related changes between rc1aa2 and rc2aa1 that can
explain a change of behaviour in bdflush.

Andrea
