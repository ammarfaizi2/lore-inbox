Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRACCjy>; Tue, 2 Jan 2001 21:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132088AbRACCjo>; Tue, 2 Jan 2001 21:39:44 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:1152 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S131391AbRACCjj>; Tue, 2 Jan 2001 21:39:39 -0500
Date: Tue, 2 Jan 2001 20:08:55 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Additional info. for PCI VIA IDE crazyness.  Please read.
Message-ID: <20010102200855.A278@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010102102900.A328@evaner.penguinpowered.com> <Pine.LNX.4.10.10101021046330.25012-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101021046330.25012-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 02, 2001 at 10:56:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and adding that option DID fix the lost interrupt problems
(ide1=0x170,0x376,15), so yeah, that fix fixed it.

Thanks for your help.  Maybe it should become a config option to enable
that (CONFIG_BLK_DEV_MESSED_UP_VIA_CHIPSET_FIX).
-- 
| Evan Thompson                    | ICQ:    2233067   |
| Freelance Computer Nerd          | AIM:    Evaner517 |
| evaner@bigfoot.com               | Yahoo!: evanat    |
| http://evaner.penguinpowered.com | MSN:    evaner517 |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
