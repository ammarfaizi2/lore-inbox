Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSKWABC>; Fri, 22 Nov 2002 19:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKWABB>; Fri, 22 Nov 2002 19:01:01 -0500
Received: from pool-151-197-236-210.phil.east.verizon.net ([151.197.236.210]:15257
	"EHLO ingchai.lan") by vger.kernel.org with ESMTP
	id <S265484AbSKWABA>; Fri, 22 Nov 2002 19:01:00 -0500
Date: Fri, 22 Nov 2002 19:08:23 -0500
From: SLion <s.lion@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.49 bk 
Message-ID: <20021123000823.GA11439@ingchai.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just pulled 2.5.49 and get the following while doing menuconfig.

  gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o
  scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o
  scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o
  scripts/lxdialog/util.o scripts/lxdialog/lxdialog.o
  scripts/lxdialog/msgbox.o -lncurses 
  ./scripts/kconfig/mconf arch/i386/Kconfig
  drivers/char/Kconfig:640: can't open file
  "drivers/char/watchdog/Kconfig"
  make: *** [menuconfig] Error 1

Looks like something got lost here.

-SL
