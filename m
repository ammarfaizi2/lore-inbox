Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280016AbRK0PEw>; Tue, 27 Nov 2001 10:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280822AbRK0PD1>; Tue, 27 Nov 2001 10:03:27 -0500
Received: from mail.galactica.it ([212.41.208.19]:40719 "EHLO galactica.it")
	by vger.kernel.org with ESMTP id <S280750AbRK0PC4>;
	Tue, 27 Nov 2001 10:02:56 -0500
From: "Matteo Sasso" <icemaze@tiscalinet.it>
To: <linux-kernel@vger.kernel.org>
Subject: Bug (?) report
Date: Tue, 27 Nov 2001 16:04:30 +0100
Message-ID: <GAELJDOEMJGDLHEONDIOEEBOCBAA.icemaze@tiscalinet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2776.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm quite a new linux user and system administrator (my own!) and I
encountered the following problems:
1) As the system starts up and the mixer settings are loaded, modprobe
complains that 'sound-slot-0' and 'sound-service-0-0' modules are not
present (in my kernel/drivers/sound directory I got just ac97_codec.o,
emu10k1, sound.o and soundcore.o). I've got a Sound Blaster Live! 5.1, a
'2.4.16-pre1' kernel and kmod usually works good, failing only with sound
(both with 'gom' mixer and with 'mpg123' player), so I have to 'modprobe
emu10k1' manually.
2) I tried for the first time to play a bit with kernel source and I was
trying to lower console_loglevel in order to have all the startup printk's
disappear. I lowered the DEFAULT_CONSOLE_LOGLEVEL constant in
'kernel/printk.c' from '7' to '5' (just to be sure) but that wasn't enough
to get rid of all those annoying KERN_INFO. Why didn't it work?

Please feel free not to answer if you don't feel like. I know I can be buggy
sometimes! :P

Thank you!
--
icemaze@tiscalinet.it

