Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273012AbSISVDq>; Thu, 19 Sep 2002 17:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273013AbSISVDp>; Thu, 19 Sep 2002 17:03:45 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:50565
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP
	id <S273012AbSISVDp>; Thu, 19 Sep 2002 17:03:45 -0400
Date: Thu, 19 Sep 2002 15:08:44 -0600
From: Reg Clemens <reg@dwf.com>
Message-Id: <200209192108.g8JL8iT6010419@orion.dwf.com>
To: linux-kernel@vger.kernel.org
Subject: Dont understand hdc=ide-scsi behaviour.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I dont understand the behaviour of kernel 2.4.18 (and probably all others) when
I put the line
		hdc=ide-scsi
on the load line.

I would EXPECT to get the ide-scsi driver for hdc (my cdwriter) but instead 
get it for BOTH hdc and hdd, the cdwriter and the zip drive.

After starting this way (with hdc=ide-scsi), I find that 
	/dev/cdrom2 -> /dev/scd0
and that to access the zip drive I have to use /dev/sda1 (or /dev/sda4)

I would EXPECT to get to them via /dev/hdd1 or /dev/hdd4.

Did I miss something or is this a bug????

				Reg.Clemens
				reg@dwf.com
