Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbSJDPjQ>; Fri, 4 Oct 2002 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262095AbSJDPjQ>; Fri, 4 Oct 2002 11:39:16 -0400
Received: from netlx009.civ.utwente.nl ([130.89.1.91]:60561 "EHLO
	netlx009.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S262094AbSJDPjP>; Fri, 4 Oct 2002 11:39:15 -0400
Date: Fri, 4 Oct 2002 17:44:35 +0200 (CEST)
From: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 : loadlin failure + analysys WAS : 2.5.32 bootfailure
 for nfsroot
In-Reply-To: <200210022109.g92L9Cp32061@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0210041731580.2792-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Denis Vlasenko wrote:

> On 1 October 2002 22:17, caligula@cam029208.student.utwente.nl wrote:
> > I build 3 kernels:zdisk,zImage and bzImge. All with gcc 2.95.3 and
> > all with the same lean kernelconfig.
> >
> > Results:
> > 1) zdisk -->booting fine from floppy,stops when it can't find a
> > rootfilesystem. which is obvious since no ide/scsci
> > /nfsroot/ramdisk/initrd  is compiled in. So thumbs up with this setup.
> >
> > 2)loadin + zImage --> loadlin loads kernel from hard disk,starts
> > unzipping . The dots which indicate the progress keeps going,until ...
> > whush,black screen followed by soft reboot.
> >
> > 3)loadlin +bzImage -->same symptoms as loadlin+zimage.
> >
> > The same setup works flawless with 2.4.x and 2.5.x <=2.5.31
> >
> > So now the questions. What did change from .31 to .32 wich could have
> > influenced the interaction of loadin with the kernel? And how can I
> > debug this?  I'm no coder but turning on debugging code with #defines
> > is in my reach.

> 
> <shameless plug>
> 
> I had some problems with loadlin too, got scared by its source,
> cooked up a replacement:
> 
> http://imtp.ilyichevsk.odessa.ua/linux/vda/linld/
> </shameless plug>
> 

Ave Denis.

I tested all the kernels  from 2.5.32 up to 2.5.40 (actually the ones who 
compiled fine with my config). They all work with linld.  Thanx for the 
tool. 

Greetz Mu








