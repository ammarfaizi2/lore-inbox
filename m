Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRKDDaJ>; Sat, 3 Nov 2001 22:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278099AbRKDD3x>; Sat, 3 Nov 2001 22:29:53 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:18122 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S278085AbRKDD2q>; Sat, 3 Nov 2001 22:28:46 -0500
Date: Sat, 3 Nov 2001 22:33:20 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: <andrewm@uow.edu.au>
Subject: 3c556 basicly not working.
Message-ID: <Pine.LNX.4.33.0111032221320.10049-100000@clubneon.clubneon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I posted a message earily to l-k, but I was really distraced at
the time, and haven't seen it show up yet, so I probally got something
wrong.

Anyway, for a little more information:  I have a 3Com mini-PCI card in my
laptop.  It is based on the 3c556 chip.  I'm using the 3c59x driver from
2.4.13-ac5.

Both compiled into the kernel or as a module I'm having no luck.  The
driver seems to load without complaints.  But reports the MAC address as
all Fs.  Actually most information I've seen returned from the card is all
Fs.

ifconfig does seem to assign an IP to the interface.  But when any traffic
is generated that tries to access the interface, it seems the machine
hangs.  It won't even change consoles.  Then I get an error in my logs
various commands not completing and I can change consoles again.  Basicly
the machine totally pauses everytime I access the interface but quickly
resumes when the command fails.

I can get what ever information you'd like to see, but I'll have to get
another network card back into the machine so I can transfer the data off.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

