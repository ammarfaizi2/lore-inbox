Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286704AbSABEYv>; Tue, 1 Jan 2002 23:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286693AbSABEYn>; Tue, 1 Jan 2002 23:24:43 -0500
Received: from unicef.org.yu ([194.247.200.148]:64764 "EHLO koala.vm")
	by vger.kernel.org with ESMTP id <S286724AbSABEYa>;
	Tue, 1 Jan 2002 23:24:30 -0500
Message-ID: <3C328B5D.2D2205CD@unicef.org.yu>
Date: Wed, 02 Jan 2002 05:23:57 +0100
From: Zoran Davidovac <zdavid@unicef.org.yu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BAD!!PATCH] Re: Promise Ultra ATA 133 TX2 support for the 2.2  
 kernelseries
X-Priority: 1 (Highest)
In-Reply-To: <20011231.VlG.50930700@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found ERROR :)

IF You look at your patches YOU WILL SEE:

Only in linux-2.2.20/drivers/block: README.buddha
Only in linux-2.2.20/drivers/block: aec62xx.c
diff -ur linux-2.2.20-vanilla/drivers/block/ali14xx.c
linux-2.2.20/drivers/bloc

so ERROR is in your patch or exactly at diff line,
the Only files are *not* in patch !!!

use diff -u -r -N or diff -u -r -P to
make diff

I send you my patches for 2.2.20 again.

Regards,

 Zoran D.



Roy Sigurd Karlsbakk wrote:
> 
> I can't get any errors... Have you tried again?
> 
> Zoran Davidovac (zdavid@unicef.org.yu) wrote*:
> >
> >Roy Sigurd Karlsbakk wrote:
> >>
> >> > You can find ATA patches in
> >> >
> >> > ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19
> >> >
> >> >  ide.2.2.19.05042001...> 15-May-2001 14:32   185k  Source code patch
> >> >
> >> > I am using it long time and it is stable,
> >> > note you will have to patch k2.2.20 manual
> >>
> >> Hi!
> >>
> >> In case anyone's interested, I've attached the 2.2.20 patch.
> >>
> >> roy
> >>
> >> --
> >> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> >>
> >> Computers are like air conditioners.
> >> They stop working when you open Windows.
> >>
> >>   ------------------------------------------------------------------------
> >>                           Name: ide-2.2.20.patch.gz
> >>    ide-2.2.20.patch.gz    Type: APPLICATION/x-gzip
> >>                       Encoding: BASE64
> >make[3]: Entering directory
> >`/usr/src/ide-patch/linux-2.2.20-royATkarlsbakk.netdrivers/block'
> >make[3]: *** No rule to make target `ide-features.c', needed by
> >`ll_rw_blk.o'.
> >Stop.
> >make[3]: Leaving directory
> >`/usr/src/ide-patch/linux-2.2.20-royATkarlsbakk.net/rivers/block'
> >make[2]: *** [first_rule] Error 2
> >make[2]: Leaving directory
> >`/usr/src/ide-patch/linux-2.2.20-royATkarlsbakk.net/rivers/block'
> >make[1]: *** [_subdir_block] Error 2
> >make[1]: Leaving directory
> >`/usr/src/ide-patch/linux-2.2.20-royATkarlsbakk.net/rivers'
> >make: *** [_dir_drivers] Error 2
> >bash-2.05#
> >
> >try to compile it with test config !
> >
> >I am attaching you my patches
> >
> >ide.2.2.20.12312001.patch.bz2 which are ide.2.2.19.05042001 ported to
> >2.2.20
> >ide-udf.2.2.20.12312001.patch.bz2 which are ide.2.2.19.05042001 with udf
> >patch ported to 2.2.20.
> >
> >try to merge your patches into it.
> >
> >Zoran
