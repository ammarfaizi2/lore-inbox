Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317868AbSGPPwX>; Tue, 16 Jul 2002 11:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317871AbSGPPwW>; Tue, 16 Jul 2002 11:52:22 -0400
Received: from host158.spe.iit.edu ([198.37.27.158]:64137 "EHLO lostlogicx.com")
	by vger.kernel.org with ESMTP id <S317868AbSGPPwU>;
	Tue, 16 Jul 2002 11:52:20 -0400
Date: Tue, 16 Jul 2002 10:55:16 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Error in the linux-2.4.19-rc1-ac5
Message-ID: <20020716105516.A22463@lostlogicx.com>
References: <20020716115840.0b76dd02.stephane.wirtel@belgacom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020716115840.0b76dd02.stephane.wirtel@belgacom.net>; from stephane.wirtel@belgacom.net on Tue, Jul 16, 2002 at 11:58:40AM +0200
X-Operating-System: Linux found 2.4.17-openmosix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use -ac6, Alan beta io-apic into submission for us.

On Tue, 07/16/02 at 11:58:40 +0200, Stephane Wirtel wrote:
> There is my .config : my file is 'config'
> -------------------------
> 
> 
> 
> In file included from pci-pc.c:17:
> /usr/src/temp/linux/include/asm/smp.h:45: AVERTISSEMENT: `INT_DELIVERY_MODE' redefined
> /usr/src/temp/linux/include/asm/smp.h:42: AVERTISSEMENT: ceci est la localisation d'une pr?c?dente d?finition
> {entrée standard}: Messages de l'assembleur:
> {entrée standard}:1121: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1206: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1291: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1368: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1379: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1390: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1469: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1481: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1493: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:1995: AVERTISSEMENT:indirect lcall sans `*'
> {entrée standard}:2105: AVERTISSEMENT:indirect lcall sans `*'
> gcc -D__KERNEL__ -I/usr/src/temp/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=pci_irq  -c -o pci-irq.o pci-irq.c
> In file included from pci-irq.c:17:
> /usr/src/temp/linux/include/asm/smp.h:45: AVERTISSEMENT: `INT_DELIVERY_MODE' redefined
> /usr/src/temp/linux/include/asm/smp.h:42: AVERTISSEMENT: ceci est la localisation d'une pr?c?dente d?finition
> gcc -D__KERNEL__ -I/usr/src/temp/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=mtrr  -DEXPORT_SYMTAB -c mtrr.c
> gcc -D__KERNEL__ -I/usr/src/temp/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=msr  -DEXPORT_SYMTAB -c msr.c
> gcc -D__KERNEL__ -I/usr/src/temp/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=cpuid  -DEXPORT_SYMTAB -c cpuid.c
> gcc -D__KERNEL__ -I/usr/src/temp/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=microcode  -DEXPORT_SYMTAB -c microcode.c
> gcc -D__KERNEL__ -I/usr/src/temp/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
> In file included from mpparse.c:25:
> /usr/src/temp/linux/include/asm/smp.h:45: AVERTISSEMENT: `INT_DELIVERY_MODE' redefined
> /usr/src/temp/linux/include/asm/smp.h:42: AVERTISSEMENT: ceci est la localisation d'une pr?c?dente d?finition
> mpparse.c:72: erreur d'analyse syntaxique avant << 0x0F >>
> mpparse.c:76: erreur d'analyse syntaxique avant << 0 >>
> mpparse.c:77: erreur d'analyse syntaxique avant << 0 >>
> mpparse.c:78: erreur d'analyse syntaxique avant << 0 >>
> mpparse.c:79: erreur d'analyse syntaxique avant << 0 >>
> mpparse.c: In function `smp_read_mpc':
> mpparse.c:601: lvalue invalide dans l'affectation
> mpparse.c:602: lvalue invalide dans l'affectation
> mpparse.c:603: lvalue invalide dans l'affectation
> mpparse.c:605: lvalue invalide dans l'affectation
> mpparse.c:616: lvalue invalide dans l'affectation
> mpparse.c:617: lvalue invalide dans l'affectation
> mpparse.c:618: lvalue invalide dans l'affectation
> mpparse.c:619: lvalue invalide dans l'affectation
> mpparse.c:620: lvalue invalide dans l'affectation
> make[1]: *** [mpparse.o] Erreur 1
> make[1]: Quitte le répertoire `/usr/src/temp/linux/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Erreur 2
> bash-2.05a# 
> 
> 
> 
> Stéphane Wirtel


