Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRHALKi>; Wed, 1 Aug 2001 07:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266715AbRHALK2>; Wed, 1 Aug 2001 07:10:28 -0400
Received: from scrabble.freeuk.net ([212.126.144.6]:63761 "EHLO
	scrabble.freeuk.net") by vger.kernel.org with ESMTP
	id <S266688AbRHALKT>; Wed, 1 Aug 2001 07:10:19 -0400
Message-ID: <002f01c11a7a$7befcd10$e4957ed4@nightblind>
From: "Jakub Burgis" <jakub@burgis.fsnet.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 freezes on init
Date: Wed, 1 Aug 2001 12:09:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm getting problems booting any 2.4 kernel on my current machine, with
fairly consistent results - the system boots, starts to output the usual
information, but locks solid after init kicks in ("init 2.78 booting").
That line prints, the cursor moves to the next line, flashes a few
times, then vanishes. The system won't respond to any input, and needs a
cold reboot. Thinking a configuration issue, I've tried passing things
such as "init=/bin/bash" to the kernel, which seems to go okay - the
same line prints, and a simple bash prompt appears, cursor flashing and
ready. I press a key... freezes again. The keystroke doesn't get echoed
to the prompt.

This happens with the 2.4.3 kernel that Mandrake 8.0 defaults to (which
thankfully includes a 2.2.19 as well), as well as numerous others (I
believe I've tried 2.4.4, 2.4.6 and 2.4.7 in addition so far). 2.2
kernels boot and run perfectly.

I'm running with a 'classic' Athlon 700 on a Gateway 'Kadoka'
motherboard (what specs they provide are here:
http://www.gateway.com/support/techdocs/references/motherboard/0aasn/0aa
sn2.shtml). PS/2 keyboard, USB or PS/2 mouse (tried both). 256mb PC100
RAM, Voodoo3 3000 or ASUS GeForce2 64mb GTS (again, both have been used
just in case) on an AGP slot.
Filesystem is hda: hda1 hda2 <hda3 hda4 hda5 hda6 hda7>, which
translates to /boot, /, /usr, /var, /home and swap, all IDE.

However, I believe the kernel image that Mandrake 8's installer uses is
a 2.4 kernel, yet that works fine. Is this a configuration setting I
need to toggle, or am I stuck until I switch motherboard?

Regards,

--
Jakub Burgis

