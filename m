Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283444AbRK3Aef>; Thu, 29 Nov 2001 19:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283447AbRK3AeZ>; Thu, 29 Nov 2001 19:34:25 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:26809 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283444AbRK3AeQ>; Thu, 29 Nov 2001 19:34:16 -0500
Date: Thu, 29 Nov 2001 17:34:11 -0700
Message-Id: <200111300034.fAU0YB904723@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
In-Reply-To: <20011130012752.0fd5380a.rene.rebe@gmx.net>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
	<200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
	<20011130012752.0fd5380a.rene.rebe@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
> On Thu, 29 Nov 2001 17:17:59 -0700
> Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
> 
> > Rene Rebe writes:
> 
> [...]
> 
> > So what's the problem? It's a similar naming scheme as used for
> > SCSI. It doesn't matter if you have something plugged into a bus, the
> > host numbering doesn't change. This is a Feature[tm].
> 
> Aeh? I can not follow. I feel completely comfortable with the names
> (strings) or subdirs, you use. My problem: I have 2
> ide-controllers. I would like to get them as host0 and host1. Boths
> with the sub-dirs bus0 and bus1.  Reading your answer I though you
> mean it is fixed due to the pci-id's - but they do not match ...

No, the "bus" I referred to was the SCSI or IDE bus. And IDE bus
supports two devices (called master and slave) while a SCSI bus
supports many more devices. It has nothing to do with PCI ID's.

> And disabling one channel in the bios shouldn't move the controller
> from host0 to host1 ... - I do not see the system-behind that ...

Um, from your previous message, it seems that host numbering doesn't
change depending on BIOS settings.

So what exactly is happening? And what is the problem? I realise you
may find the naming a little confusing, but is there an actual
problem?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
