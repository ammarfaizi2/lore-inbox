Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRKMVqz>; Tue, 13 Nov 2001 16:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279416AbRKMVqp>; Tue, 13 Nov 2001 16:46:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279317AbRKMVqh>; Tue, 13 Nov 2001 16:46:37 -0500
Date: Tue, 13 Nov 2001 16:45:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: fdutils.
In-Reply-To: <Pine.GSO.3.96.1011113214448.11222E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.95.1011113162546.134A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Maciej W. Rozycki wrote:

> On Tue, 13 Nov 2001, H. Peter Anvin wrote:
> 
> > >  Hmm, Sun used to have a software-controlled standard floppy drives years
> > > ago... 
> > 
> > I'm not talking about Suns.
> 
>  I'm just pointing out there used to be no problem with making a
> software-controlled eject for a legacy floppy device even long ago if one
> wanted to. 
> 
> > >  Based on local obervations hardly anyone uses floppies anymore...  They
> > > are mostly used for system rescue purposes, where the kind of a device
> > > doesn't really matter.
> > 
> > ... except that you no longer can fit a reasonable system rescue/install
> > setup on a floppy, so it *defintitely* matters.  Also, the floppy device
> > is like a rash all over the hardware; it maintains a highly undesirable
> > legacy.

Hmm. I have a two-floppy rescue system with enough software thereon to
boot the system, install modules for SCSI, install a new SCSI hard-disk,
recover files using tar from off a tape and/or compressed CDROM or
network.

The boot floppy contains a comprssed ram disk and the other is just
ext2 mounted off /usr/bin on the ram disk. If I needed more stuff,
I would mount a cdrom off from /usr/bin, instead.

Without a floppy-based rescue system, you have to use bootable CDROM,
usually supplied by a vendor, without the tools to truly rescue a
system. You can only re-install. For instance some vendors don't
provide a SCSI-tape module so you can't recover from a SCSI tape.

In any event, you have to roll your own if you want to truly recover.
It only takes two floppies. If your hard-disk file system isn't
corrupt, it only takes one floppy.

> 
>  You only confirm what I wrote -- hardly anyone uses floppies, so there is
> no need to keep mechanical compatibility in devices -- a complete dump of
> 1.44" FD support would be almost harmless.  Hence whether a Zip or a
> LS-120 -- it doesn't really matter.  You need new media anyway. 

It would be a disaster, hardly harmless. Have you a clue how much
work gets done off-site (perhaps at home), using "sneaker-net"
(floppies)? Engineers who have to work for a living take work home
every night. They don't have to take a whole source-code tree because
they have already duplicated their work environment via CDROM or tape.
They take home, work on, and return, current source-code or
documentation on floppies.

Whether or not these Engineers have home connections to the Internet
means nothing because their companies (often) deny access to their
workstations from the "outside". The only way to do your job is
via sneaker-net. You get rid of floppies and you get rid of Engineers.

FYI, the current trend here it to remove all I/O devices from
PC/Workstations, requiring everybody to boot off the network. This
makes sure that everybody is running the same M$Garbage.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


