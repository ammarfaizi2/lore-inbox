Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbRBAAhe>; Wed, 31 Jan 2001 19:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129916AbRBAAhZ>; Wed, 31 Jan 2001 19:37:25 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:28424 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129696AbRBAAhG>; Wed, 31 Jan 2001 19:37:06 -0500
Message-ID: <3A78AFAF.82FCB4F2@Hell.WH8.TU-Dresden.De>
Date: Thu, 01 Feb 2001 01:37:03 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Keyboard Scancode Problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

With all the latest kernels (at least since 2.4.0-test12)
I have had occasional problems with a PS/2 keyboard when
switching back and forth between X and text consoles.

In most cases the problem occurs when switching from X to
a text console, which renders the keyboard totally unusable.
Pressing any key results in ^W ^E and other garbage.
Sometimes pressing Ctrl fixes the problem, other times not
even SysRq works.

The kernel logs the following stuff:

keyboard: unrecognized scancode (70) - ignored
keyboard: unrecognized scancode (66) - ignored
keyboard: unknown scancode e0 71
keyboard: unknown scancode e0 70

and so forth. I cannot reliably reproduce it though.

Can someone enlighten me whether this is a keyboard problem,
X problem or something wrong with the kernel's console stuff?

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
