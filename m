Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSFOKNg>; Sat, 15 Jun 2002 06:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSFOKNg>; Sat, 15 Jun 2002 06:13:36 -0400
Received: from ccs.covici.com ([209.249.181.196]:17555 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S315239AbSFOKNf>;
	Sat, 15 Jun 2002 06:13:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15627.4943.678449.561717@ccs.covici.com>
Date: Sat, 15 Jun 2002 06:13:35 -0400
From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.21 make problem
X-Mailer: VM 7.05 under Emacs 21.3.50.1
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I am having a terrible time compiling 2.5.21 -- first some
missing includes which I think I have fixed and now at the very end
of the process after the modules have been installed I get the
following:

make[1]: Entering directory `/usr/src/linux-2.5.21/arch/i386/boot'
gcc -E  -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA -DRAMDISK=512 bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
make[1]: *** No rule to make target `/usr/src/linux-2.5.21/include/linux/compile.h', needed by `bsetup.s'.  Stop.

Any help would be appreciated with this.

-- 
         John Covici
         covici@ccs.covici.com
