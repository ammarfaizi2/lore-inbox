Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSKOMCX>; Fri, 15 Nov 2002 07:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKOMCX>; Fri, 15 Nov 2002 07:02:23 -0500
Received: from m3.azalea.se ([217.75.96.207]:38818 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S266233AbSKOMCW>;
	Fri, 15 Nov 2002 07:02:22 -0500
From: "Mikael Olenfalk" <mikael@netgineers.se>
To: "'Chris Wedgwood'" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.19-xfs eating filehandles when compiled with gcc 3.2
Date: Fri, 15 Nov 2002 13:22:03 +0100
Organization: Netgineers HB
Message-ID: <000d01c28ca1$9ab8f0b0$0501a8c0@devnet.vodha>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20021115113505.GA27887@tapu.f00f.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When using Gentoo 1.3 (which uses gcc-2.95.4+) I did not experience
these problems even if the packages where almost the same versions (some
packages changed while I was doing the transition).

I'm using the gentoo kernel 2.4.19 with xfs patches, gentoo has included
some other patches too, don't have the list at hand but I can come back
to that later.

I imagine getting some fuzzy warning messages when compiling the kernel,
in the XFS subtree, I can post these if you're interested.

I'll try the newest 2.5.x kernel as soon as the machine finished
bootstrapping again (just reinstalling the system with
CHOST="i686-pc-linux-gnu" CFLAGS="-march=athlon-xp -O3 -pipe
-fomit-frame-pointer" CXXFLAGS=$CFLAGS).

I really don't want to give up a GCC 3.2 built system with
-march=athlon-xp since the build time for a kernel decreased by almost
90 seconds after a bootstrap. I.e. a system compiled with gcc3.2
compiled a kernel at 5 minutes and a gcc2.95.4+ system compiled the same
kernel with the same .config in 6:27 minutes.


Regards,
Mikael

-----Original Message-----
> From: Chris Wedgwood [mailto:cw@f00f.org]
> Sent: den 15 november 2002 12:35
> To: Mikael Olenfalk
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.19-xfs eating filehandles when compiled with gcc 3.2
> 
> On Fri, Nov 15, 2002 at 11:17:18AM +0100, Mikael Olenfalk wrote:
> 
> > I have a Gentoo Linux 1.4 RC1 system, that ships with a GCC 3.2
> > compiler and 2.4.19 with the XFS patches (and IMON btw).
> 
> Does it happen when you use gcc-2.95.4+ ?
> 
> 
>   --cw

