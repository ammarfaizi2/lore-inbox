Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263148AbTC1VUr>; Fri, 28 Mar 2003 16:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbTC1VUr>; Fri, 28 Mar 2003 16:20:47 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:5255 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263148AbTC1VUq>; Fri, 28 Mar 2003 16:20:46 -0500
Date: Fri, 28 Mar 2003 16:26:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: more details on laptop keyboard problems, 2.5.66-bk4
Message-ID: <Pine.LNX.4.44.0303281617510.1175-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  ok, here's a little more info.  as i was booting my dell
laptop with 2.5.66-bk4, just after the "Starting sendmail"
message, i got a screenful of

  atkbd.c: Unknown key (set 0, scancode 0x0, on isa0060/serio1) pressed.

i did in fact build support for an AT keyboard (CONFIG_KEYBOARD_ATKBD)
directly into the kernel, since it seemed based on the explanation
that i needed that.  (to refresh your memory, i have both the built-in
keyboard and a PS/2 keyboard which is plugged into the combo 
keyboard/mouse port on the back, and under 2.4.18, both are
functional at the same time.)

  another interesting symptom is that, as the system was booting,
i was prompted by kudzu whether or not to remove the configuration
for the missing Sharp SL series (Zaurus).  i selected yes, and not
only did i get to the correct dialog screen, but the next button
i *would* have selected was pressed automatically.  

  it was as if having pressed CR once translated into two CRs,
one per screen.  very strange.

  finally (and probably related to power management), after waiting
at the "Starting sendmail" prompt for about a minute, the laptop
simply turned itself off.  not good.

  but one step at a time -- any suggestions regarding that "atkbd.c"
error??  i'm assuming that i really need that option selected, no?

rday

