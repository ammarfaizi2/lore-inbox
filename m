Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbRBGTTx>; Wed, 7 Feb 2001 14:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRBGTTd>; Wed, 7 Feb 2001 14:19:33 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:51460 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129708AbRBGTT0>; Wed, 7 Feb 2001 14:19:26 -0500
Date: Wed, 7 Feb 2001 13:14:39 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jakub Jelinek <jakub@redhat.com>, Gregory Maxwell <greg@linuxpower.cx>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207131439.A28015@vger.timpanogas.org>
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org> <20010206190624.C23960@vger.timpanogas.org> <20010206210731.E1110@xi.linuxpower.cx> <20010207110852.A27089@vger.timpanogas.org> <20010207123213.V16592@devserv.devel.redhat.com> <20010207113147.A27215@vger.timpanogas.org> <20010207103719.A1037@kochanski.internal.splhi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010207103719.A1037@kochanski.internal.splhi.com>; from timw@splhi.com on Wed, Feb 07, 2001 at 10:37:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii

On Wed, Feb 07, 2001 at 10:37:19AM -0800, Tim Wright wrote:
> Umm, I don't know what compiler you've got etc. Jeff, but I just tried gcc-2.96
> (-69) here, and '#ident' is supported and works perfectly. The only way to even
> get a warning is to use '-ansi -pedantic' which yields:
> junk.c:1:2: warning: ISO C does not allow #ident
> 
> I don't think the problem is with gcc, at least not the Red Hat 7.0 version.
> 
> Tim


Try 7.1.  This is where I got the errors.  They are attached.

Jeff


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="error.txt"

CONFIG_MODVERSIONS=y
Linux MODVERSIONED symbol support detected
Linux SMP support disabled in kernel source tree
OS=Linux
CPU=INTEL
ADAPTER=psb64
Make command is
LSMP=
make ADAPTER=psb64 OS=Linux CPU=INTEL
os is Linux
make ADAPTER=psb64 OS=Linux CPU=INTEL
+ cd ./LINUX/os
+ make -f Makefile all 'CC=cc -O3 -DEXPORT_SYMTAB' OS=Linux ENDIX=le ENDIAN=-DLITTLE_ENDIAN SILENT=y
make[1]: Entering directory `/usr/src/redhat/SOURCES/pci-sci-1.1/src/IRM/drv/src/LINUX/os'
Compiling init.c ....
In file included from init.c:30:
../../prolog.h:344:8: invalid #ident
make[1]: *** [init.o] Error 1
make[1]: Leaving directory `/usr/src/redhat/SOURCES/pci-sci-1.1/src/IRM/drv/src/LINUX/os'
make: *** [all.sub] Error 1
targidr is /usr/src/redhat/SOURCES/pci-sci-1.1/src/IRM/drv/linuxgen
Building /usr/src/redhat/SOURCES/pci-sci-1.1/src/IRM/lib
makefile.unix:6: ../drv/INCLUDE/mkirm.def: No such file or directory
make: *** No rule to make target `../drv/INCLUDE/mkirm.def'.  Stop.
make ADAPTER=psb64 OS=Linux CPU=INTEL
make: *** No targets specified and no makefile found.  Stop.
Building /usr/src/redhat/SOURCES/pci-sci-1.1/src/IRM/util
make ADAPTER=psb64 OS=Linux CPU=INTEL
Makefile:7: ../drv/INCLUDE/mkirm.def: No such file or directory
make: *** No rule to make target `../drv/INCLUDE/mkirm.def'.  Stop.
removing scidiag from /usr/src/redhat/SOURCES/pci-sci-1.1/src/IRM/bin
Done

--jRHKVT23PllUwdXP--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
