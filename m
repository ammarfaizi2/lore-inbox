Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRBHBf3>; Wed, 7 Feb 2001 20:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRBHBfU>; Wed, 7 Feb 2001 20:35:20 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:26130 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131010AbRBHBfA>; Wed, 7 Feb 2001 20:35:00 -0500
Message-ID: <3A8205D4.7C7E358E@Hell.WH8.TU-Dresden.De>
Date: Thu, 08 Feb 2001 03:35:00 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac5 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PS/2 Mouse/Keyboard conflict and lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan et. all

I'm not sure whether this is related to the ominous ps/2 mouse bug
you have been chasing, but this problem is 100% reproducible and
very annoying.

After upgrading my Asus A7V Bios from 1003 to 1005D, gpm no longer
receives any mouse events and the mouse doesn't work in text
consoles. Once I kill gpm and restart gpm -t ps2 the keyboard
locks up.

Logging in remotely and looking at dmesg revealed the following:

keyboard: Timeout - AT keyboard not present?
keyboard: unrecognized scancode (70) - ignored

If I don't kill and restart gpm, but start X, the mouse works
perfectly, but only in X.

Any ideas?

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
