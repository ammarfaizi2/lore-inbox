Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbSLKRbT>; Wed, 11 Dec 2002 12:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbSLKRbT>; Wed, 11 Dec 2002 12:31:19 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:60438 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S267239AbSLKRbS>; Wed, 11 Dec 2002 12:31:18 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A7801130352@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Dave Jones'" <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: 2.5 Changes doc update.
Date: Wed, 11 Dec 2002 12:38:51 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IDE.
> ~~~~

> - Known problems with the current IDE code. 
>   o  Simplex IDE devices (eg Ali15x3) are missing DMA sometimes
>   o  Serverworks OSB4 may panic on bad blocks or other non 
> fatal errors
>   o  PCMCIA IDE hangs on eject
>   o  Most PCMCIA devices have unload races and may oops on eject
>   o  Modular IDE does not yet work, modular IDE PCI modules sometimes
>      oops on loading
>   o  Silicon Image controllers give really bad performance currently.
> 

FWIW to you, though I know this is mostly x86 centric, there are Endian
issues with current 2.5 IDE, and Big Endian machines such as sparc64 won't
work right now with IDE.

B.
