Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266386AbSKZQIQ>; Tue, 26 Nov 2002 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSKZQIQ>; Tue, 26 Nov 2002 11:08:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29410 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S266386AbSKZQIP>; Tue, 26 Nov 2002 11:08:15 -0500
Date: Tue, 26 Nov 2002 11:16:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-rc4
Message-ID: <Pine.LNX.4.44L.0211261115330.698-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The main reason for -rc4 is that the ISDN fix in -rc3 was problematic.


Summary of changes from v2.4.20-rc3 to v2.4.20-rc4
============================================

<marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc4
  o Cset exclude: ralf@dea.linux-mips.net|ChangeSet|20021030170645|00078

<ralf@dea.linux-mips.net>:
  o The BLKGETSIZE ioctl expects an unsigned long argument

Adrian Bunk <bunk@fs.tum.de>:
  o Fix ips driver .text.exit errors

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix the fix

Oleg Drokin <green@namesys.com>:
  o Do not allow to mount reiserfs with blocksize != 4k

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix arch/ppc/Makefile so it builds on POWER3
  o PPC32: Ignore SIGURG if not caught

Rui Sousa <rui.sousa@laposte.net>:
  o Emu10k1 bugfixes


