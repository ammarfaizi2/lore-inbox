Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292867AbSBVOMo>; Fri, 22 Feb 2002 09:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292870AbSBVOMe>; Fri, 22 Feb 2002 09:12:34 -0500
Received: from dns.texnet.it ([151.99.150.6]:15876 "EHLO dns.texnet.it")
	by vger.kernel.org with ESMTP id <S292869AbSBVOMc> convert rfc822-to-8bit;
	Fri, 22 Feb 2002 09:12:32 -0500
Date: Fri, 22 Feb 2002 15:20:34 +0100 (CET)
Message-ID: <000501c1bbaa$f67ce820$0201000a@texnetpo.net>
From: "Niccolo Rigacci" <niccolo@texnet.it>
To: <linux-kernel@vger.kernel.org>
Subject: Console keyboard on headless box (no VGA card)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to configure a Linux box (i386) which has no video card, but has
a keyboard (PS/2) attached, to still have the console working. The kernel
I'm using (2.4.16) disables /dev/tty? if it finds that no video cards are
present, and so also the keyboard is disabled.

I know what I'm doing, please don't ask why I:
1) use a so strange configuration
2) don't use a serial console
3) don't spend a few bucks to put a VGA inside

I'm searching where to put my hands on, to have this working (console.c,
vt.c, kernel?). Kernels 2.2.x behave differently: they didn't disable the
keyboard. A frame-buffer console can do the trick?

For the curious: I have several headless servers, and I need a simple way to
let people to do a system halt or reboot without logging in remotely. A
blind key sequence on the keyboard is the best solution, I think.

Thanks In Advance

Please cc to me also.

Niccolo Rigacci
Firenze - Italy



