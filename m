Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263627AbSIUUxI>; Sat, 21 Sep 2002 16:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275934AbSIUUxH>; Sat, 21 Sep 2002 16:53:07 -0400
Received: from 62-190-218-141.pdu.pipex.net ([62.190.218.141]:1285 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263627AbSIUUxH>; Sat, 21 Sep 2002 16:53:07 -0400
Date: Sat, 21 Sep 2002 22:06:15 +0100
From: jbradford@dial.pipex.com
Message-Id: <200209212106.g8LL6FKP001764@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Serial port monitoring with keyboard LEDs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to add code to use the keyboard LEDs as serial port Tx/Rx LEDs, somwehat analogous to an external modem, (I.E. for links to things other than modems, that typically don't have LEDs).

I'm using a 2.4.19 kernel as a reference, and looking at putting my code in /drivers/char/serial.c, specifically at the serial_in and serial_out functions, is this the Right Thing or not?  Obviously the LEDs won't actually reflect what is going out on the serial line, because of buffering, etc, and also, what's going to be more useful - just flash on and off for each byte sent, or LED on for 1, LED off for 0 bit?  That would be even more of an approximation to what's actually happening on the serial line, because obviously we're sending a byte at a time to the serial port.

Any pointers to docs I should read would be appreicated :-)

John.
