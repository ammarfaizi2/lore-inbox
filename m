Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290104AbSAWVQi>; Wed, 23 Jan 2002 16:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290105AbSAWVQ3>; Wed, 23 Jan 2002 16:16:29 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:28797 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290104AbSAWVQO>; Wed, 23 Jan 2002 16:16:14 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Wed, 23 Jan 2002 22:16:11 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0201232148210.2478-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201232148210.2478-100000@infcip10.uni-trier.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020123211611.8E0151458@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 23. January 2002 21:49, Daniel Nofftz wrote:
> On Wed, 23 Jan 2002, Hans-Peter Jansen wrote:
> > Hi Daniel & folks,
> >
> > just tried your patch on my (diskless) asus a7v133 (kt133) with 1.2 GHz
> > Athlon. I normally had 14% base load spend in apmd-idled and a CPU temp.
> > of 45°C. After getting it to work, I see a base load of around 1% (mostly
> > spend in artsd), but CPU is only 1°-2° less now :-( I hoped, it it
> > would be more). Nevertheless, it is a very important patch nowadays where
> > temperature is the last technical barrier, and energy saving an economic
> > necessity.
>
> hmmm ... 1°-2° lesser than apm or lesser than "without any powersafing
> function" ?

Oups, should have quoted my config:
2.4.18-pre4+
linux-2.4.18-NFS_ALL.dif
pnpbios.patch_latest
apm-idle-2.diff
btaudio-2.4.17.diff.gz
bttv-0.7.88-2.4.17.diff.gz
imon-0.0.2-2.4.12-hp
00_nanosleep-5.dif
ide.2.4.16.12102001.patch.bz2

You see, I'm fiddleing with power saving quite some time.

BTW: Would some enlighted kernel brain explain, why 
    [ ]     RTC stores time in GMT
is only available, when APM is enabled. Does this mean, I cannot
define my RTC mode when using ACPI?

> do you have entered the amd_disconnect=yes flag at boot-time (LILO ?)

Yup, it's called mknbi-linux here :)

I'm going to check ACPI mode without your patch now.

> > Many thanks and greetings from Berlin to Trier ;)
> >   Hans-Peter
>
> thanks ... greetings back to you ... :)
>
> daniel
>
>
> # Daniel Nofftz
> # Sysadmin CIP-Pool Informatik
> # University of Trier(Germany), Room V 103
> # Mail: daniel@nofftz.de

Cheers,
  Hans-Peter
