Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131201AbQKCTgV>; Fri, 3 Nov 2000 14:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131394AbQKCTgL>; Fri, 3 Nov 2000 14:36:11 -0500
Received: from exchange-1.cadmus.com ([207.78.64.6]:22790 "EHLO
	exchange-1.cadmus.com") by vger.kernel.org with ESMTP
	id <S131201AbQKCTgC>; Fri, 3 Nov 2000 14:36:02 -0500
Message-ID: <3A032175.C2DDFFFA@cadmus.com>
Date: Fri, 03 Nov 2000 15:35:01 -0500
From: "Ethan C. Baldridge" <BaldridgeE@cadmus.com>
Organization: Cadmus Journal Services
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hardware lock-up with 2.4.0-test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on my box at work, which is a Pentium 200 with 64 megs of ram.

no strange messages in /var/log/messages, no commonality I've found
between the lockups.  This doesn't happen if I go back to 2.2.16 (which
I'm in right now).

Twice the lock-up occurred while initscripts were running on boot-up (at
different places in the initscripts).  Twice now it has happened while
I've been away from my computer for a while, both times apparently after
the screensaver has come on (black screen).

I'm running with DevFS and devfsd, IDE hard drive (Intel 82371SB PIIX3
controller), 3com 3C905 ethernet card, Intel 82439HX Triton II chipset
motherboard, Pentium with F00F bug.

Has anyone else seen this, and can you give me any suggestions?

Thanks,
Ethan Baldridge
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
