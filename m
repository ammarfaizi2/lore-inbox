Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRAWKkS>; Tue, 23 Jan 2001 05:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbRAWKkJ>; Tue, 23 Jan 2001 05:40:09 -0500
Received: from staff0130.dada.it ([195.110.97.130]:14209 "EHLO
	blacksheep.at.dada.it") by vger.kernel.org with ESMTP
	id <S129826AbRAWKjv>; Tue, 23 Jan 2001 05:39:51 -0500
Date: Tue, 23 Jan 2001 11:32:57 +0100 (CET)
From: Patrizio Bruno <patrizio@dada.it>
To: "Trever L. Adams" <trever_Adams@bigfoot.com>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <3A6D56EE.2070003@bigfoot.com>
Message-ID: <Pine.LNX.4.10.10101231129450.22934-100000@blacksheep.at.dada.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that your linux's partition has not been overwritten, but only the MBR
of your disk, so you probably just need to reinstall lilo. Insert your
installation bootdisk into your pc, then skip all the setup stuff, but the
choose of the partition where you want to install and the source from where
you want to install, then select just the lilo configuration (bootconfiguration
I mean), complete that step and reboot your machine, lilo will'be there again.

P.

On Tue, 23 Jan 2001, Trever L. Adams wrote:

> Mike A. Harris wrote:
> 
> > On Mon, 15 Jan 2001, Trever Adams wrote:
> > 
> > I don't see how Windows 9x can be at fault in any way shape or
> > form, if you can boot between 2.2.x kernel and 9x no problem, but
> > lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
> > everything.  Windows does not touch your Linux fs's, so if there
> > is a problem, it most likely is a kernel bug of some kind that
> > doesn't initialize something properly.
> 
> Well, I boot into Linux, all is fine, rebooted into a different version 
> of Linux for some testing, all is fine (this was an older version, I 
> believe it was 2.2.14 or .15)  Try to install ME and run it, seems ok. 
> Go back to Linux, and my drive was fried with Windows files all over it, 
> etc.
> 
> I know Windows shouldn't touch a Linux partition.  But, apparently it 
> did.  Or else Linux and/or Fdisk are fried and made a bad partition table.
> 
> > Windows sucks, and I hate it as much (probably more) than the
> > next guy.  It's not fair to blame every computer problem on it
> > though unless you KNOW that Windows directly caused the problem.
> 
> I said what I did, because it seems the evidence said Windows did do it. 
>   If it didn't, oops.  I have talked with others and they had a similar 
> experience, so I am not alone.
> 
> > Pick one of the 1000000000 good reasons to say Windows sucks
> > instead...
> > 
> > For what it is worth, I have a similar problem where if I boot
> > Windows (to show people what "multicrashing" is), if I boot back
> > into Linux, my network card no longer works (via-rhine).  Most
> > definitely a Linux bug.  In this case, "via-rhine.o" sucks.
> > 
> > ;o)
> 
> Well, this is actually the second time I have had Windows write all over 
> my Linux partition.  The first time I think it was not a bug in either, 
> but a bug in hardware.  However, I no longer have that hardware as my 
> desktop.
> 
> Trever
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

---------------------------------------------------------
Patrizio Bruno
DADA spa / Ed-IT Development Staff
Borgo degli Albizi 37/r
50122 Firenze
Italy
tel +39 05520351
fax +39 0552478143

PGP PublicKey available at: http://www.keyserver.net/en/
---------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
