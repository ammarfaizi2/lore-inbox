Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRC2KvW>; Thu, 29 Mar 2001 05:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132704AbRC2KvO>; Thu, 29 Mar 2001 05:51:14 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:39172 "EHLO
	babsi.intermeta.de") by vger.kernel.org with ESMTP
	id <S132700AbRC2KvA>; Thu, 29 Mar 2001 05:51:00 -0500
Date: Thu, 29 Mar 2001 12:50:10 +0200
From: "Henning P . Schmiedehausen" <hps@intermeta.de>
To: Erik van Asselt <e.van.asselt@planet.nl>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Promise RAID controller howto?
Message-ID: <20010329125010.M1809@forge.intermeta.de>
Reply-To: hps@intermeta.de
In-Reply-To: <Pine.LNX.4.10.10103270806300.16125-100000@master.linux-ide.org> <3AC31147.6035E09C@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AC31147.6035E09C@planet.nl>; from "Erik van Asselt" on Thu, Mar 29, 2001 at 12:41:11PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as far as I can see (you're talking about the "rel.tgz" archive from
the LinuxBETA directory, don't you?), this is just glue code for their
binary only "ftlib.o" driver.

No real open source here. Maybe Andre can work something from the
header structures.  But then again, the archive is dated 9/28/2000,
it's not exactly new...

	Regards
		Henning



On Thu, Mar 29, 2001 at 12:41:11PM +0200, Erik van Asselt wrote:
> Hmmmmm i have the Promise raid source for 2.2 kernel modules so what do you mean
> by opensource signatures
> 
> i have it working for 2.2 kernels but i can't get it to work properly in 2.4
> So if someone want to look at the source !!!
> it can be found on www.promise.com
> 
> Assie
> 
> Andre Hedrick schreef:
> 
> > On Tue, 27 Mar 2001, Henning P. Schmiedehausen wrote:
> >
> > > Hi,
> > >
> > > I know, that this is a FAQ and the Promise RAID controller card is not
> > > yet usable as a RAID board under Linux 2.x but is there a way to use
> > > the controller just like the UltraATA 100 controller?
> >
> > It is not a raid board ... it is a raid lie
> >
> > > I know, that "input high == UltraATA core, input low = RAID core"
> > > according to Andre Hedrick but I really don't care about the RAID
> > > core. I want to use this controller to drive JBOD.
> >
> > Wrong, if Promise will opensource the signatures then we map the software
> > raid against that location and use Linux's soft-raid.
> >
> > > Can one do this? The disks need not to be interchangeable to other
> > > controllers.  Just be accessible.
> > >
> > > 2.2 solutions preferred, 2.4 ok.
> > >
> > >       Regards
> > >               Henning
> > >
> > > --
> > > Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> > > INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> > >
> > > Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> > > D-91054 Buckenhof     Fax.: 09131 / 50654-20
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> > Andre Hedrick
> > Linux ATA Development
> > ASL Kernel Development
> > -----------------------------------------------------------------------------
> > ASL, Inc.                                     Toll free: 1-877-ASL-3535
> > 1757 Houret Court                             Fax: 1-408-941-2071
> > Milpitas, CA 95035                            Web: www.aslab.com
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
