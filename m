Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSFYDnx>; Mon, 24 Jun 2002 23:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFYDnw>; Mon, 24 Jun 2002 23:43:52 -0400
Received: from wsip68-15-187-123.ph.ph.cox.net ([68.15.187.123]:29122 "EHLO
	lithium.mrduck.net") by vger.kernel.org with ESMTP
	id <S314278AbSFYDnv>; Mon, 24 Jun 2002 23:43:51 -0400
Date: Mon, 24 Jun 2002 20:43:49 -0700 (MST)
From: Chris Rode <electro@mrduck.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1: undefined reference to `change_floppy'
Message-ID: <Pine.LNX.4.44.0206242037320.5740-100000@lithium.mrduck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with CONFIG_BLK_DEV_FD not defined, I get on the final link:

init/do_mounts.o: In function `rd_load_image':
init/do_mounts.o(.text.init+0x91b): undefined reference to `change_floppy'
init/do_mounts.o: In function `rd_load_disk':
init/do_mounts.o(.text.init+0xa45): undefined reference to `change_floppy'
make: *** [vmlinux] Error 1

I can send a complete .config, if needed.

Thanks,
--Chris.


