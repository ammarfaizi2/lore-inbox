Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281910AbRLDRmP>; Tue, 4 Dec 2001 12:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRLDRkr>; Tue, 4 Dec 2001 12:40:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22723 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283197AbRLDRka>; Tue, 4 Dec 2001 12:40:30 -0500
Date: Tue, 4 Dec 2001 10:40:26 -0700
Message-Id: <200112041740.fB4HeQu08196@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.1-pre5 AudioCD with cdrom modules
In-Reply-To: <3C0D087D.573B6174@wanadoo.fr>
In-Reply-To: <3C0CC182.B65B6A52@wanadoo.fr>
	<200112041657.fB4GvQV06981@vindaloo.ras.ucalgary.ca>
	<3C0D087D.573B6174@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> Richard Gooch wrote:
> > 
> > Pierre Rousselet writes:
> > > What may cause an AudioCD no being recognized at first attempt but
> > > only after unloading/reloading the modules ide-cd cdrom ?
> > >
> > > I'm testing 2.5.1-pre5 + devfs-patch-v202.
> > >
> > > My CRD-8240B is known as /dev/cdroms/cdrom0 in fstab, to mount it
> > > manually on /cdrom, and in the gnome CD player gtcd preferences panel.
> > >
> > > ide-cd and cdrom are loaded at boot time (i don't need that, 2.4.16 does
> > > it as well). After loging in i can mount /cdrom but if it is an AudioCD
> > > gtcd tells me 'no disc'.
> > >
> > > After rmmod ide-cd cdrom, gtcd finds the AudioCD OK.
> > >
> > > This doesn't happen on plain 2.4.16
> > 
> > Please try kernel 2.4.17-pre2 + devfs-patch-v199.2. That will help
> > determine if the problem is devfs-related, or (more likely) due to the
> > block I/O changes happening in 2.5.
> 
> Excellent, can you hear Diana Krall?

??? You'll have to explain what you mean by this.

> 2.4.17-pre2 + devfs-patch-v199.2 does not have this feature. The
> AudioCD is identified at the first attempt.

OK, since 2.4.17-pre2 + devfs-patch-v199.2 works fine, it suggests the
block I/O changes in 2.5. I've Cc'ed Jens, who likes hearing about
these problems :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
