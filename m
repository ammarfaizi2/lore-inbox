Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSLTTXO>; Fri, 20 Dec 2002 14:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSLTTXO>; Fri, 20 Dec 2002 14:23:14 -0500
Received: from mail114.mail.bellsouth.net ([205.152.58.54]:47342 "EHLO
	imf14bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S265077AbSLTTXM>; Fri, 20 Dec 2002 14:23:12 -0500
Date: Fri, 20 Dec 2002 14:31:14 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.51+] kernel not honoring init= bootparm?
Message-ID: <Pine.LNX.4.43.0212201422580.2382-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that somewhere in between 2.5.51 and 2.5.52-bk2 (and still in
52-bk4), the kernel no longer pays attention to init=whatever when
booting.

Does anybody else see this?

The bootloader is still passing it

LILO 22.3.3 boot: 2.5.52-bk2 init=/bin/bas
Loading 2.5.52-bk2.......................
<snip>
Kernel command line: BOOT_IMAGE=2.5.52-bk2 root=302 console=ttyS0,9600
console=tty0 init=/bin/bash

but init still loads.

This is single x86, Debian Testing.

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


