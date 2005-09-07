Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVIGHRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVIGHRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIGHRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:17:31 -0400
Received: from koto.vergenet.net ([210.128.90.7]:3530 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751103AbVIGHRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:17:31 -0400
Date: Wed, 7 Sep 2005 15:00:50 +0900
From: Horms <horms@debian.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, LT-P <LT-P@lt-p.net>,
       321442@bugs.debian.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc (drivers/ide/ppc/pmac.c)
Message-ID: <20050907060050.GD22231@verge.net.au>
References: <E1E13vT-0008G7-R1@arda.LT-P.net> <20050808085703.GE18551@verge.net.au> <20050814005430.2e26e627@arda.LT-P.net> <C2F63384-9CC2-4979-956B-8CB5DA77F4AE@mac.com> <58cb370e0509050542b512131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58cb370e0509050542b512131@mail.gmail.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 02:42:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Should be fixed in 2.6.13.
> 
> On 8/16/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > On Aug 13, 2005, at 18:54:30, LT-P wrote:
> > > Le lun 08 aoû 2005 17:57:04 CEST, Horms <horms@debian.org> a écrit:
> > >> Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolves
> > >> your
> > >> problem. If it does, then the following patch should fix Kconfig
> > >> so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_PMAC
> > >> to be enabled. It should patch cleanly against Debian's 2.6.8 and
> > >> Linus' current Git tree.
> > > It seems to solve the problem, thanks.
> > > Sometimes, I feel like I am the only person in the world to compile
> > > the kernel on
> > > powerpc... :)
> > 
> > Actually, I ran into this same bug a day or so ago when updating to
> > 2.6.13-rc6,
> > it's just I noticed the error, fixed my config, then recompiled and
> > forgot
> > about it completely until now :-D.  Thanks for the bug report, though!

thanks

-- 
Horms
