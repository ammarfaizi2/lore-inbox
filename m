Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318146AbSHDK5Y>; Sun, 4 Aug 2002 06:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSHDK5Y>; Sun, 4 Aug 2002 06:57:24 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:38189 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S318146AbSHDK5X>; Sun, 4 Aug 2002 06:57:23 -0400
Message-Id: <200208041100.AA00109@prism.kumin.ne.jp>
Date: Sun, 04 Aug 2002 20:00:44 +0900
To: linux-kernel@vger.kernel.org
Subject: VESA VGA Graphic console has bug ?
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I use linux-2.5.30 with VESA VGA Graphic console at slackware-8.1 based environment.
when I use emacs( 21.2 ), these situation occured. (I used to boot up with vga=771)

(1) # emacs /tmp/test
    I type a line ( /sbin/ifconfig lo 127.0.0.1 ), and save file.

(2) # emacs /tmp/test
    a line ( /sbin/ifconfig lo 127.0.0.1 ) displayed in emacs frame.

(3) I wand to insert few spaces between /sbin/ifconfig and lo.
    when I type a space, then a line change to a line ( /sbin/ifconfig  oo 127.0.0.1 ).
    I could not edit a line as I want to edit.
    this situation display only. when I save file and re-read file, results were fine.

(4) I boot up PC ( erase VGA option ), I checked this test, everything OK.

I checked a same test at linux-2.5.26,28,30 and got a same result.
I checked at linux-2.4.19, it is OK( everything work fine with vga=771 ).
I thinked VESA VGA Graphic console has bug to display in emacs frame.

Before VESA VGA Graphic console occured kernel panic at linux-2.5.14,15.
from linux-2.5.16 VESA VGA Graphic console compile and work fine,
but Pengin Image did not display at boot up time. is it OK?

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
