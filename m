Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSCOJdu>; Fri, 15 Mar 2002 04:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSCOJdj>; Fri, 15 Mar 2002 04:33:39 -0500
Received: from Expansa.sns.it ([192.167.206.189]:17680 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S287862AbSCOJd2>;
	Fri, 15 Mar 2002 04:33:28 -0500
Date: Fri, 15 Mar 2002 10:31:34 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Thunder from the hill <thunder@ngforever.de>
cc: linux-kernel@vger.kernel.org, Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
In-Reply-To: <3C90ECDF.8EBC8FD4@ngforever.de>
Message-ID: <Pine.LNX.4.44.0203151027560.24394-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HPT370 IDE Raid is not really an hardware raid.
It is a software Raid, since Linux does not use tha raid implementation
that comes with the BIOS, but it uses softwareraid.


On Thu, 14 Mar 2002, Thunder from the hill wrote:

> Martin Eriksson wrote:
>
> > What is "best" on Linux 2.4.X (with any appropriate patches) ?
> >
> > HPT370 RAID-1 or Software RAID-1 ?
> >
> > And if Software RAID-1 is best of these two, where is it most stable; on an
> > i815 chipset, a VIA chipset (686B) or on a promise controller?
> >
> > I define "best" as:
> > * most stable
> > * least complex setup
> > * least hassle when something goes wrong
>
> Software RAID is just your disk configuration. But I'd recommend
> hardware raid because the rebuild after one disk crash is dog slow with
> software raid. This problem been discussed in all possible linux
> magazines...
> I prefer SCSI RAID5
>
> Thunder
> --
> begin-base64 755 -
> IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
> dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
> IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
> dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
> LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
> IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
> XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
> fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
> c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
> ====
> Extract this and see what will happen if you execute my
> signature. Just save it to file and do a
> > uudecode $file | perl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

