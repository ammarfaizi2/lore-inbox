Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSH1NT0>; Wed, 28 Aug 2002 09:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSH1NTZ>; Wed, 28 Aug 2002 09:19:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:55491 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318816AbSH1NTY>; Wed, 28 Aug 2002 09:19:24 -0400
Date: Wed, 28 Aug 2002 15:27:48 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.5.32-mm1
Message-ID: <20020828132748.GA7466@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <3D6C500E.426B163A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6C500E.426B163A@zip.com.au>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://piggie:pages@www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.4.20-pre4-ac2 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 27 2002, Andrew Morton wrote:

[....]
make[1]: Entering directory /usr/src/linux/init'
Generating /usr/src/linux/include/linux/compile.h (updated)
gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
-c -o version.o version.c
ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory /usr/src/linux/init'
ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/linux/arch/i386/lib/lib.a lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a drivers/built-in.o
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
fs/fs.o: In function recalc_bh_state':
fs/fs.o(.text+0x5932): undefined reference to cpu_possible'
make: *** [vmlinux] Error 1
chiara:/usr/src/linux #

-- 
# Heinz Diehl, 68259 Mannheim, Germany
