Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130126AbRBZDLE>; Sun, 25 Feb 2001 22:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130129AbRBZDKy>; Sun, 25 Feb 2001 22:10:54 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:40197
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130126AbRBZDKk>; Sun, 25 Feb 2001 22:10:40 -0500
Date: Sun, 25 Feb 2001 19:09:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeremy Jackson <jerj@coplanar.net>
cc: Derrik Pates <dpates@andromeda.dsdk12.net>, linux-kernel@vger.kernel.org
Subject: Re: IDE floppy drives and devfs - no device nodes if no disk loaded
  atboot
In-Reply-To: <3A99C060.D56ADF28@coplanar.net>
Message-ID: <Pine.LNX.4.10.10102251908450.27669-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have HOTSWAP ATA completed, but will release after IDF.
It will be used to blow MircoSoft out of the water at IDF.

On Sun, 25 Feb 2001, Jeremy Jackson wrote:

> Derrik Pates wrote:
> 
> > Subject says about all there is to say. I have figured out that IDE drives
> > are enumerated as part of the boot-time partition check in
> > fs/partitions/check.c, but if I don't have something loaded at boot time
> > (IDE SuperDisk in PC at home, IDE Zip 100 in G3 tower at work), I never
> > get device nodes at all with devfs. Something really needs to be done
> > about this, IMHO.
> 
> hdparm's got a cmd line switch to unregiser/register and ide interface.
> It tried it *once* and it just complained about cmd line args being wrong...
> i'll have to look into it more.  when working it should help your situation.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

