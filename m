Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262869AbSJGFXI>; Mon, 7 Oct 2002 01:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262870AbSJGFXH>; Mon, 7 Oct 2002 01:23:07 -0400
Received: from adsl-216-62-201-42.dsl.austtx.swbell.net ([216.62.201.42]:46464
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S262869AbSJGFXH>; Mon, 7 Oct 2002 01:23:07 -0400
Subject: EVMS breaking menuconfig in 2.5.40?
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033968519.3948.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 07 Oct 2002 00:28:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got EVMS from cvs, found the 2.5.40 patch, applied it, then attempted
to do make menuconfig. 

All that happens is this:

[austin@UberGeek linux-2.5.40]$ make menuconfig
make[1]: Entering directory `/data/build/linux-2.5.40/scripts'
make -C lxdialog all
make[2]: Entering directory `/data/build/linux-2.5.40/scripts/lxdialog'
make[2]: Leaving directory `/data/build/linux-2.5.40/scripts/lxdialog'
make[1]: Leaving directory `/data/build/linux-2.5.40/scripts'
/bin/sh ./scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions, parsing

and then my console becomes unuseable, I can't even ssh in from another
box, then X dies eventually. 

If I hit and hold ctrl-c for a few seconds after this begins, I can
usually break out, but if I miss it, then well, X blows up pretty good.

make config, works, and xconfig doesn't work for me at all for some
reason. I'll get there yet. :) Wish I had more time to play and diagnose
this. 

--The GrandMaster

