Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279922AbRKVQL7>; Thu, 22 Nov 2001 11:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279950AbRKVQLt>; Thu, 22 Nov 2001 11:11:49 -0500
Received: from victor.ndsuk.com ([194.202.59.31]:26125 "EHLO
	tempest.chil.ndsuk.com") by vger.kernel.org with ESMTP
	id <S279969AbRKVQLj>; Thu, 22 Nov 2001 11:11:39 -0500
Message-ID: <F128989C2E99D4119C110002A507409801C52F89@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Swap vs No Swap.
Date: Thu, 22 Nov 2001 16:11:29 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hum think I'm going to test this idea out tonight, quick question without
swap at what point would the kernel stop giving memory up for cache
purposes. For example I noticed on Tuesday whist doing a back up of a file
system (in-line tar cd untar) I was left with ~4 Mb left having nearly the
rest of my 2Gb Ram used for cache.

Would this ram be given back to the free pool much more readily? 


> -----Original Message-----
> From: war [mailto:war@starband.net]
> Sent: 22 November 2001 16:01
> To: Oliver Neukum; linux-kernel@vger.kernel.org
> Subject: Re: Swap vs No Swap.
> 
> 
> Once again, I have enough ram where I am not going to run out 
> for the things I
> do.
> I never need swap.
> 
> When the system swaps, it slows down the system 
> responsiveness big time.
> 
> 
> Oliver Neukum wrote:
> 
> > Am Donnerstag 22 November 2001 02:53 schrieb war:
> > > I do not understand something.
> > >
> > > How can having swap speed ANYTHING up?
> > >
> > > RAM = 1000MB/s.
> > > DISK = 10MB/s
> > >
> > > Ram is generally 1000x faster than a hard disk.
> > >
> > > No swap = fastest possible solution.
> >
> > At some point you will run out of ram. Then you have to 
> start paging. The
> > only question there is whether you page only mmaped files 
> including program
> > code or whether you also write out program data.
> >
> >         HTH
> >                 Oliver
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
