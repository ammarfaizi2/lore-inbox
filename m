Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbTCIEfO>; Sat, 8 Mar 2003 23:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbTCIEfN>; Sat, 8 Mar 2003 23:35:13 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13330 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262479AbTCIEfK>; Sat, 8 Mar 2003 23:35:10 -0500
Date: Sun, 9 Mar 2003 01:46:33 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Mueller <malware@t-online.de>, Russell King <rmk@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030309044633.GC9359@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Michael Mueller <malware@t-online.de>,
	Russell King <rmk@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
	Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk> <20030306231905.M838@flint.arm.linux.org.uk> <1046996987.17718.144.camel@irongate.swansea.linux.org.uk> <200303070715.IAA27138@fire.malware.de> <1047041676.20793.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047041676.20793.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 07, 2003 at 12:54:36PM +0000, Alan Cox escreveu:
> On Fri, 2003-03-07 at 07:15, Michael Mueller wrote:
> > Hi Alan,
> > Sorry, but I must join Russel here. I have atleast one machine which has
> > a bootloader able to load exactly one file only. There is currently no
> > way to load an initrd. It would need to implement the whole (BOOTP+)TFTP
> > stuff again, just to get the initrd. So I was quite happy linux 2.4
> > still knows about mounting a NFS root filesystem without user-space
> > help.
> 
> Just glue the initrd to the kernel. This is not rocket science

arch/sparc/boot/piggyback.c

   Simple utility to make a single-image install kernel with initial ramdisk
   for Sparc tftpbooting without need to set up nfs.

   Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
   Pete Zaitcev <zaitcev@yahoo.com> endian fixes for cross-compiles, 2000.

- Arnaldo
