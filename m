Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbSJBWPM>; Wed, 2 Oct 2002 18:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbSJBWPM>; Wed, 2 Oct 2002 18:15:12 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:63361 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S262683AbSJBWPK>; Wed, 2 Oct 2002 18:15:10 -0400
Date: Wed, 2 Oct 2002 18:20:34 -0400
From: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: undefined reference to __io_virt_debug
Message-ID: <20021002182034.D656@ma-northadams1b-3.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.40, attempted compile for Pentium II with most options
set to 'm', details available on request.

-Eric

-------------------------------------
ld -m elf_i386  -Ttext 0x100000 -e startup_32 head.o misc.o piggy.o -o vmlinux 
misc.o: In function `puts':
misc.o(.text+0x1d10): undefined reference to `__io_virt_debug'
misc.o(.text+0x1d4b): undefined reference to `__io_virt_debug'
misc.o(.text+0x1d76): undefined reference to `__io_virt_debug'
misc.o(.text+0x1da8): undefined reference to `__io_virt_debug'
make[2]: *** [vmlinux] Error 1

