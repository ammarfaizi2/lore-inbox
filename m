Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTBNViQ>; Fri, 14 Feb 2003 16:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268490AbTBNVgi>; Fri, 14 Feb 2003 16:36:38 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37783 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267466AbTBNU4V>; Fri, 14 Feb 2003 15:56:21 -0500
Date: Fri, 14 Feb 2003 16:06:13 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302142106.h1EL6Do29394@devserv.devel.redhat.com>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc IDE in 2.4.20
In-Reply-To: <mailman.1045255810.17251.linux-kernel2news@redhat.com>
References: <mailman.1045255810.17251.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is IDE known to be broken on Sparc in 2.4.20?  I just got this compile
> failiure:
> sparc-linux-ld -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o arch/sparc/kernel
> drivers/ide/idedriver.o: In function `ide_end_drive_cmd':
> drivers/ide/idedriver.o(.text+0x11d4): undefined reference to `inw_p'

I tested it in 2.4.7 for the last time. It probably bitrotted.
Why do you care? I posess the only IDE capable sparc on this planet.
Just configure it out, and be happy.

Are you sure you did not want to compile for sparc64, hint, hint?

-- Pete
