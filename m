Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTBAPwI>; Sat, 1 Feb 2003 10:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTBAPwI>; Sat, 1 Feb 2003 10:52:08 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:49605 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264883AbTBAPwH>; Sat, 1 Feb 2003 10:52:07 -0500
From: "Oliver Friedrich" <oliver@familie-friedrich.de>
To: <linux-kernel@vger.kernel.org>
Subject: Keyboard acces
Date: Sat, 1 Feb 2003 17:00:22 +0100
Message-ID: <BCEFLCEOHFPNLLAKKGAACECCCMAA.oliver@familie-friedrich.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.6; AVE: 6.16.0.0; VDF: 6.16.0.5; host: friedrich.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know, if this is realy kernel related, but i don't know a better
place.

I want to access the local keyboard. Because i have at normal operation no
graphic adapter on this computer, the application is not able to access the
keyboard via the /dev/vc/[1..n], because the kernel runs it console on the
serial port. If i'm using a vga adapter, this is not a problem.

Normaly the application (it is VDR, the Video Disk Recorder from Klaus
Schmidinger) uses the input of one of the virtual terminal devices
/dev/tty[1..n] (or /dev/vc/[1..n] in case of devfs), specified via a command
line option.


Now to my question:
Is there a device available, that i can use to read the local keyboard if
the kernel runs its console on one of the serial ports? It is a normal AT
compatible keyboard, not a USB device.

It is not possible to let the vga card inside of the computer, because it
would not fit into the small case.

Any hints for my problem? Or another mailing list or forum where i can
search for a solution?

Thanks in advance,
Oliver

