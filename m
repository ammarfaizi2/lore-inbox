Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSG2XuT>; Mon, 29 Jul 2002 19:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSG2XuT>; Mon, 29 Jul 2002 19:50:19 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:24206 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318143AbSG2XuS>;
	Mon, 29 Jul 2002 19:50:18 -0400
Date: Tue, 30 Jul 2002 01:53:40 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207292353.BAA23087@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.29: bug in ide and hd kernel option handling
Cc: martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my 486 test box (ISA/VLB only, CONFIG_PCI=n), passing any
any ide or hd kernel option (like idebus=33) to 2.5.29 results
in a kernel hang at boot: I get the initial "Uncompressing ..
booting .." and then nothing.
With 2.5.27, the kernel instantly rebooted itself instead.

I don't know when this problem appeared. I only recently starting
experimenting with ide kernel options in an attempt to get an
old qd6580 controller card going -- alas the second channel
never wants to show up :-(

/Mikael
