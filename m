Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbRDUXJR>; Sat, 21 Apr 2001 19:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133021AbRDUXJJ>; Sat, 21 Apr 2001 19:09:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133019AbRDUXIt>; Sat, 21 Apr 2001 19:08:49 -0400
Subject: Re: a way to restore my hd ?
To: ville.holma@pp.htv.fi (Ville Holma)
Date: Sun, 22 Apr 2001 00:10:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, ville.holma@pp.htv.fi
In-Reply-To: <000701c0ca7b$051934a0$6786f3d5@pp.htv.fi> from "Ville Holma" at Apr 21, 2001 06:52:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14r6WZ-0004XM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The memory I had was however somehow corrupt and after I got my new system
> booted up and used it a little it became shaky and then locked hard and I
> could do nothing but reset it. I suppose this was caused by the
> malfunctioning memory but I can't be sure, I know there has been problems
> with the via chipset also.

Nod

> debian:~# e2fsck /dev/hdb7
> e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
> Corruption found in superblock.  (frags_per_group = 2147516416).

Try e2fsck -b 8193 /dev/hdb7

(and 16384, 32768)

This is a backup copy of the superblock.

