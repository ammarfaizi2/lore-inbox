Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUAJRhI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAJRhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:37:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:18330 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265267AbUAJRhE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:37:04 -0500
X-Authenticated: #16884229
Date: Sat, 10 Jan 2004 18:37:36 +0100
From: Robert =?ISO-8859-1?Q?F=FChricht?= <the_master_of_disaster@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm2 build fails on Athlon64
Message-Id: <20040110183736.12fe45c6@hephaestos.kepler>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this is the right place to post, please forgive me if this is not the case.

Building 2.6.1-mm2 fails on my Athlon64 with:


  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.text+0x4bf7): In function `do_IRQ':
: undefined reference to `kgdb_process_breakpoint'
make: *** [.tmp_vmlinux1] Error 1

Can anyone help here? Please reply to the_master_of_disaster AT gmx DOT at, as I am no subscriber of this list, thank you!

Thanks in advance,
Robert Führicht

-- 
Post tenebras lux, post fenestras tux
