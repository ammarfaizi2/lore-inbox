Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTAECYl>; Sat, 4 Jan 2003 21:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTAECYl>; Sat, 4 Jan 2003 21:24:41 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:61709 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S262360AbTAECYk>;
	Sat, 4 Jan 2003 21:24:40 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200301050233.h052X9J26642@oboe.it.uc3m.es>
Subject: printk__R_ver_printk
To: linux-kernel@vger.kernel.org
Date: Sun, 5 Jan 2003 03:33:09 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled 2.4.20 with MODVERSIONS set, and all th ekernel symbols
came out as (according to /proc/ksyms)

     printk__R_ver_printk

(for example). System.map and the modules themselves are clean. No suffixes
on the symbol names, of any kind.

I couldn't load any modules, of course, not even with insmod -f.
The modules themselves depmod'ed fine against the System.map

Does anyone recognize this symptom? I presume it's a messed up binutils
or modutils. I did have to update binutils for some recent 2.5 kernels,
and I vaguely recall some warnings ...

 ii  binutils       2.12.90.0.1-4  The GNU assembler, linker and binary utiliti
 ii  util-linux     2.11b-4        Miscellaneous system utilities.
 ii  gcc            2.95.2-13.1    The GNU C compiler.
 ii  modutils       2.4.15-1       Linux module utilities.

I'll move gcc up to 2.95.3, but I don't think that should impact,
should it ..?

Peter
