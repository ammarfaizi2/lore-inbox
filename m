Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTDGNPw (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTDGNPw (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:15:52 -0400
Received: from tomts23.bellnexxia.net ([209.226.175.185]:41693 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263435AbTDGNPv (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 09:15:51 -0400
Date: Mon, 7 Apr 2003 09:23:19 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: USB optical mouse on laptop causes bk12 boot to hang
Message-ID: <Pine.LNX.4.44.0304070918200.1380-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  on to the next issue.  the setup:
	dell inspiron 8100 laptop
	RH 9
	2.5.66-bk12

  for ergonomic reasons, rather than use the laptop keyboard and
touchpad, i have (under the previous RH 8 and 2.4.20) been using
an external PS/2 keyboard and logitech USB optical mouse.  this
setup has been working fine -- when both external input devices
are connected, i can use either keyboard, and just the optical
USB mouse.

  booting under 2.5.66-bk12, if just the keyboard is connected,
no problem.  the boot works, both keyboards are active, and the
touchpad works.

  however, if i connect *only* the optical mouse, the boot gets
to "Freeing unused kernel memory", hangs for about a minute, 
then powers down the box.  not good.  (same thing happens if 
both external keyboard and mouse are connected, so i've isolated
it to just the optical mouse).

  thoughts?

rday

