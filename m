Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRGJKQK>; Tue, 10 Jul 2001 06:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRGJKQA>; Tue, 10 Jul 2001 06:16:00 -0400
Received: from mail17.bigmailbox.com ([209.132.220.48]:21773 "EHLO
	mail17.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S265249AbRGJKPt>; Tue, 10 Jul 2001 06:15:49 -0400
Date: Tue, 10 Jul 2001 03:15:38 -0700
Message-Id: <200107101015.DAA29269@mail17.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.52.111]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: linux-kernel@vger.kernel.org
Cc: rddunlap@osdlab.org
Subject: i810 I/O APIC (was Sticky IO-APIC problem)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D'oh!  Well, I still haven't gotten the APIC to work... after *several* unclean reboots (and repeatedly checking my hex math), I'm back where I started.  After tinkering inside the configuration space of the I/O Controller Hub, no change is evident in /proc/interrupts.  The next time I start up XFree86, it freezes at a blank screen.  No vterm switches, Magic SysRq keys, or three-fingered salutes rescue me from it; the kernel doesn't even sing a verse of "Aiee, Killing My Interrupt Handler Softly".  Nothin' + bupkus.  Nothing.  Well, it's obviously not going to work from user space. 8-(  Any thoughts from the gurus out there?

     -- Colin


On the first day, man created the computer.  On the second day, God proclaimed from the heavens, "F0 0F C7 C8".

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!
