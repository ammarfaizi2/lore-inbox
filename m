Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUCHAoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbUCHAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:44:12 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:5148 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262358AbUCHAoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:44:06 -0500
Date: Mon, 8 Mar 2004 01:43:47 +0100
Message-Id: <200403080043.i280hlYj005348@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@trabinski.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4-rc2
In-Reply-To: <Pine.LNX.4.58.0403032229450.5202@ppc970.osdl.org>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 5C87 7FF4 9539 6AA9 4EEF  529D 0236 ECCB 70F1 E978
X-Key-ID: 70F1E978
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.3 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0403032229450.5202@ppc970.osdl.org> you wrote:
> 
> Here's mainly ARM, XFS, PCI hotplug and firewire updates. And some parport
> cleanups and fixes from Al.
> 

[root@space-themes linux-2.6.3]# make
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  LD      drivers/input/mouse/psmouse.o
  LD      drivers/input/mouse/built-in.o
  LD      drivers/input/built-in.o
  LD      drivers/input/serio/built-in.o
  CC      drivers/net/8139too.o
drivers/net/8139too.c: In function `rtl8139_open':
drivers/net/8139too.c:1326: error: `CONFIG_8139_RXBUF_IDX' undeclared (first use in this function)
drivers/net/8139too.c:1326: error: (Each undeclared identifier is reported only once
drivers/net/8139too.c:1326: error: for each function it appears in.)
drivers/net/8139too.c: In function `rtl8139_rx':
drivers/net/8139too.c:1943: error: `CONFIG_8139_RXBUF_IDX' undeclared (first use in this function)
drivers/net/8139too.c: In function `rtl8139_close':
drivers/net/8139too.c:2248: error: `CONFIG_8139_RXBUF_IDX' undeclared (first use in this function)
make[2]: *** [drivers/net/8139too.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


-- 
*[ £T ]*
