Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280662AbRKJNva>; Sat, 10 Nov 2001 08:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280664AbRKJNvT>; Sat, 10 Nov 2001 08:51:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2576 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280662AbRKJNvH>; Sat, 10 Nov 2001 08:51:07 -0500
Subject: Re: scsi BLKGETSIZE breakage in -pre2
To: akpm@zip.com.au (Andrew Morton)
Date: Sat, 10 Nov 2001 13:57:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml), alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3BECD87F.F53234B2@zip.com.au> from "Andrew Morton" at Nov 09, 2001 11:34:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162Ydz-0006Qf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sd_ioctl() was changed to pass BLKGETSIZE off to blk_ioctl(),
> but blk_ioctl() doesn't implement it.
> 
> So `cfdisk /dev/sda' is failing.
> 
> Simply copying the -ac version of blkpg.c across fixes
> it for me.

I'm feeding Linus stuff bit by bit - I managed to misorder that one.
