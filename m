Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSEJJVV>; Fri, 10 May 2002 05:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEJJVU>; Fri, 10 May 2002 05:21:20 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:28947 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313206AbSEJJVT> convert rfc822-to-8bit; Fri, 10 May 2002 05:21:19 -0400
Date: Fri, 10 May 2002 11:21:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Pierre Bernhardt <mirrorgate@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Subject: Re: 2.5.15 hangs at partition check
Message-ID: <20020510092102.GA8467@louise.pinerecords.com>
In-Reply-To: <3CDB8092.8090007@wanadoo.fr> <3CDB86C3.8050706@gmx.de> <1021020050.25667.20.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 18 days, 4:01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Xavier Bestel <xavier.bestel@free.fr>, May-10 2002, Fri, 10:40 +0200]
> Le ven 10/05/2002 à 10:37, Pierre Bernhardt a écrit :
> > 
> > Pierre Rousselet wrote:
> > 
> > > PIII / Abit BE6 HPT366, devfs.
> > > 
> > > 2.5.15 doesn't boot, the last lines are :
> > > 
> > > hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
> > > hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
> > > Partition check:
> > >  /dev/ide/host2/bus0/target0/lun0:
> > > 
> > > 2.5.14 works, it gives :
> > > hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
> > > hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
> > > Partition check:
> > >  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
> > >  /dev/ide/host3/bus0/target0/lun0: p1
> > 
> > 
> > Hi,
> > 
> > i have the same problem on Abit BP6 with HPT366 and Kernel 2.4.18 based
> > on SuSE 8.0 SMP-Kernel.
> > 
> > Partition check:
> >   hda: hda1 hda2 hda3 hda4
> >   hdc: hdc1 hdc2 hdc3 hdc4
> >   hde:
> 
> Tried to disable ACPI ?

I don't think ACPI compiles in 2.5.15.

In file included from /usr/src/linux-2.5.15/arch/i386/pci/acpi.c:2:
.tmp_include/src_000/include/linux/acpi.h:38: ../../drivers/acpi/include/acpi.h: No such file or directory
In file included from /usr/src/linux-2.5.15/arch/i386/pci/acpi.c:2:
.tmp_include/src_000/include/linux/acpi.h:294: parse error before cpi_generic_address'
.tmp_include/src_000/include/linux/acpi.h:294: warning: no semicolon at end of struct or union
.tmp_include/src_000/include/linux/acpi.h:295: warning: type defaults to 	nt' in declaration of c_data'
.tmp_include/src_000/include/linux/acpi.h:295: warning: data definition has no type or storage class
.tmp_include/src_000/include/linux/acpi.h:299: parse error before }'
.tmp_include/src_000/include/linux/acpi.h:299: warning: empty declaration
.tmp_include/src_000/include/linux/acpi.h:363: parse error before cpi_handle'
.tmp_include/src_000/include/linux/acpi.h:363: warning: no semicolon at end of struct or union
.tmp_include/src_000/include/linux/acpi.h:363: warning: no semicolon at end of struct or union
.tmp_include/src_000/include/linux/acpi.h:365: parse error before }'
.tmp_include/src_000/include/linux/acpi.h:365: warning: type defaults to 	nt' in declaration of ource'
.tmp_include/src_000/include/linux/acpi.h:365: warning: data definition has no type or storage class
.tmp_include/src_000/include/linux/acpi.h:366: parse error before }'
pp_makefile5: Main command (pid 3685) returned 1
make[1]: *** [arch/i386/pci/acpi.o] Error 1


T.
