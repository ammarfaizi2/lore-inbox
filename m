Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135394AbRDMEC0>; Fri, 13 Apr 2001 00:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135395AbRDMECR>; Fri, 13 Apr 2001 00:02:17 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:18694
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135394AbRDMECB>; Fri, 13 Apr 2001 00:02:01 -0400
Date: Thu, 12 Apr 2001 21:01:46 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Stephen Woodbridge <woodbri@mediaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <3AD64568.28E170B6@mediaone.net>
Message-ID: <Pine.LNX.4.10.10104122052210.4564-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

Just telling me this fact is preaching to the choir, you have to express
this on the mailing list, so others can hear first hand that you dislike
the product and their support is non-existant.

You will get no support for kernels that are not precompiled with distros,
that will be a fact.  They have ne desire or intention to support linux.
Instead of accepting help, the patronize.

The insult the global linux community with phrases like: 'we are more
concerned with quality and compatablity, than to runs to market...'

Yet they have yet to follow the programming rules of modules, including
the basics of spinlocks/semephores/queue-locks.

So great icon of compatablity with the other os, is vaporware.
You should not trust that their driver will protect you other OS if you
access under Linux.  I expect it to eat and damage it just like you are
seeing you Linux partitions being eaten.

Sorry, but http://www.linux-ide.org/ clearly states that nothing below a
given line supports hardware/bios-soft raid.

Regards,

Andre Hedrick
Linux ATA Development

On Thu, 12 Apr 2001, Stephen Woodbridge wrote:

> Andre,
> 
> Thank you for your quick response. I was afraid that was going to be the
> situation. They have not been much help. I guess I will just buy another
> regular ATA/100 controller and use software RAID. I wish I had know this
> before I spent the money on the FastTrack100 controller.
> 
> Best regards,
>   -Steve
> 
> Andre Hedrick wrote:
> > 
> > Stephen,
> > 
> > Sorry but that is a closed source driver and you have to goto Promise, LOL.
> > Last time I talked to them they sent me an email virus that choked a drive.
> > Scan your mail first and then count your fingers if you have to shake
> > hands with somebody their....
> > 
> > Andre Hedrick
> > Linux ATA Development
> > 
> > On Thu, 12 Apr 2001, Stephen Woodbridge wrote:
> > 
> > > Andre,
> > >
> > > I have searched everywhere for some help getting my Promise
> > > FrastTrack/100 Raid controller working. I finally found the ft.o driver
> > > on the Promise website and have gotten it installed correctly (I think),
> > > but I can NOT get fdisk to recognize the drive. Any help would be
> > > greatly appreciated.
> > >
> > > Best regards,
> > >   -Stephen Woodbridge
> > >
> > > Here is what I have done so far:
> > >
> > > RedHat 6.2
> > > Linux 2.2.18
> > > (No other scsi devices in system)
> > >
> > > I added to /etc/conf.modules
> > >   alias block-major-8 ft
> > > and copied the ft.o to /lib/modules/2.2.18/scsi
> > > and did the depmod -a
> > > and rebooted
> > >
> > >   (after boot) ...
> > > [root@linus /root]# lsmod
> > > Module                  Size  Used by
> > > lockd                  44688   0  (autoclean) (unused)
> > > sunrpc                 58820   0  (autoclean) [lockd]
> > > 3c509                   5996   1  (autoclean)
> > > tulip                  31888   1  (autoclean)
> > > es1371                 25920   0
> > > soundcore               2596   4  [es1371]
> > >
> > > [root@linus /root]# fdisk /dev/sda    # tried repeatedly
> > >
> > > Unable to open /dev/sda
> > >
> > > [root@linus /root]# lsmod
> > > Module                  Size  Used by
> > > ft                     71048   0  (autoclean) (unused)
> > > scsi_mod               38372   1  (autoclean) [ft]
> > > lockd                  44688   0  (autoclean) (unused)
> > > sunrpc                 58820   0  (autoclean) [lockd]
> > > 3c509                   5996   1  (autoclean)
> > > tulip                  31888   1  (autoclean)
> > > es1371                 25920   0
> > > soundcore               2596   4  [es1371]
> > > [root@linus /root]#
> > >
> > > When fdisk tried to access /dev/sda the module was loaded and the
> > > following banner shows up on the console:
> > >
> > > TastTrack Driver v1.10 build 3 (06.OCT.2000)
> > > scsi0 : FASTTRACK
> > > scsi : 1 host
> > >   Vendor: Promise Model: 1x2 Mirror/RAID1 Rev 1.10
> > >   Type:   Direct-Access                   ANSI SCSI revision: 02
> > >   Vendor: Promise Model: 1x2 Mirror/RAID1 Rev 1.10
> > >   Type:   Direct-Access                   ANSI SCSI revision: 02
> > >   Vendor: Promise Model: 1x2 Mirror/RAID1 Rev 1.10
> > >   Type:   Direct-Access                   ANSI SCSI revision: 02
> > >   Vendor: Promise Model: 1x2 Mirror/RAID1 Rev 1.10
> > >   Type:   Direct-Access                   ANSI SCSI revision: 02
> > >

