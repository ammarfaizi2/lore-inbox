Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbRLASU5>; Sat, 1 Dec 2001 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284193AbRLASUr>; Sat, 1 Dec 2001 13:20:47 -0500
Received: from manfe1.infinite.com ([199.29.68.121]:62481 "EHLO
	MailAndNews.com") by vger.kernel.org with ESMTP id <S284180AbRLASUf>;
	Sat, 1 Dec 2001 13:20:35 -0500
X-WM-Posted-At: MailAndNews.com; Sat, 1 Dec 01 13:19:23 -0500
Message-ID: <00dc01c17a94$b37c2290$0500a8c0@myroom>
From: "Matt Schulkind" <mschulkind@mailandnews.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Date: Sat, 1 Dec 2001 13:19:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Dec 01, 2001 at 11:34:00AM +0100, you
[Sven.Riedel@tu-clausthal.de] claimed:
> > On Sat, Dec 01, 2001 at 11:58:03AM +0200, Ville Herva wrote:
> > > - how come anyone else is not seeing this corruption (Abit KT7A,
nevermind
> > >   HPT370 is fairly popular)?
> >
> > A friend of mine had an IBM DLTA drive attached to his HPT370
> > controller, and this combination proved to produce a whole lot of drive
> > errors (I can confirm this first hand), which went away after attaching
> > the drive to the main motherboard controller.
> > I can't say anything about data corruption though - I just asked him and
> > he said he didn't know of any, but that doesn't mean it didn't happen.
>
> Of course the drive is longer attached to HPT370 and your friend is
propably
> reluctant to reattach it, but it would still be nice to know if he gets
> consistent results which for example this simple test:
>
>   cat /dev/hde | mdsum
>
> run for several (5-10, perhaps) times.
>
> OTOH, I haven't had corruption with reading only
> one disk at a time, but then again I haven't tried too hard as they
> should really work in parallel.
>
>
> -- v --
>
> v@iki.fi
> -

In my experience, the HPT370 chipset likes corrupting harddrives. When I was
using it, I had the PCI Raid version and it kept corrupting my hard drives.
I tried updating the BIOS, but the bios program locked up and completly
killed my board. When I RMAed the board, the new BIOS was put on for me and
after that I ahven't had a single problem. Maybe you should try upgrading
the BIOS, but I don't know if you can for an onboard version.

-Matt Schulkind


