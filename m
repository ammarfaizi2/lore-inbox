Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314179AbSD1ST7>; Sun, 28 Apr 2002 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314449AbSD1ST6>; Sun, 28 Apr 2002 14:19:58 -0400
Received: from arcus.sinus.cz ([195.39.17.7]:10368 "EHLO arcus.sinus.cz")
	by vger.kernel.org with ESMTP id <S314179AbSD1ST5>;
	Sun, 28 Apr 2002 14:19:57 -0400
Date: Sun, 28 Apr 2002 20:19:55 +0200
From: Pavel Troller <patrol@sinus.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.10 freezes while booting with AMD Opus chipset
Message-ID: <20020428181955.GA11623@arcus.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
  I tried to run 2.5.10 on my MSI K7D Master Dual Athlon board.
  Normally I'm running 2.4.18 but it oopses if I try to burn a CD (ATAPI, SCSI
emulated) in the swapper. So I tried 2.5 line to see if the things are going
better.
  The IDE chipset gets recognized as AMD Opus (a difference from 2.4.18),
the kernel lists IDE devices attached, then writes

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

and that's all. The cursor stays at the end of this line, disk LED is off and
the system is dead. Manual reset/power cycle is required.

  I noted that before it complains that it cannot assign irq 17 to my eth card
using ACPI, but I think it's not related.

  Is this problem known, or am I the first who reports it ? 
  Should I enable the serial console, catch all the boot log to another system
and post it ?

  Please CC: explicitely to me as I'm not a member of linux-kernel.

                                               With regards, Pavel Troller
