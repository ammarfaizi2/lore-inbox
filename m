Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbTAQEEX>; Thu, 16 Jan 2003 23:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbTAQEEX>; Thu, 16 Jan 2003 23:04:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267282AbTAQEEV>;
	Thu, 16 Jan 2003 23:04:21 -0500
Date: Thu, 16 Jan 2003 20:08:37 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Carl Gherardi <C.Gherardi@curtin.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.5.59
In-Reply-To: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au>
Message-ID: <Pine.LNX.4.33L2.0301162007080.11494-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Carl Gherardi wrote:

| Hey all,
|
| Just done a bk pull and got this
|
| # make mrproper; make menuconfig
| ....
| gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o
| scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o
| scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o scripts/lxdialog/util.o
| scripts/lxdialog/lxdialog.o scripts/lxdialog/msgbox.o -lncurses
| ./scripts/kconfig/mconf arch/i386/Kconfig
| arch/i386/Kconfig:1185: can't open file "drivers/eisa/Kconfig"
| make: *** [menuconfig] Error 1

Hm, that's odd.  That file is in the downloaded .bz2 file.

I would pull again or do 'bk changes -R' or some other bk
command to check its integrity.

Or maybe it's just not 'got' (checked out) by bk...

-- 
~Randy

