Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289661AbSAWH15>; Wed, 23 Jan 2002 02:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289702AbSAWH1r>; Wed, 23 Jan 2002 02:27:47 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:22189 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289661AbSAWH1f> convert rfc822-to-8bit; Wed, 23 Jan 2002 02:27:35 -0500
Date: Wed, 23 Jan 2002 08:27:29 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Dave Jones <davej@suse.de>, Andreas Jaeger <aj@suse.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <200201230512.g0N5CIr12742@home.ashavan.org.>
Message-ID: <Pine.LNX.4.40.0201230814310.29728-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Timothy Covell wrote:
> 1. According to AMD specs, the model 3 Duron's don't
> use more that 40 Watts maximum.
>
> 2. With my Duron 800 on a KT133A chipset
> running folding@home and seti@home
> continuously, LM sensors reports:
>
> SYS Temp: +45.2°C
> CPU Temp: +35.1°C
> SBr Temp: +25.8°C
>
>
> So, I see absolutely no cause for alarm, nor even a need for
> lvcool (esp. not when running seti@home).   And  I certainly
> haven't seen any Athlon PSE/AGP lockups.  So, are you all
> overclockng your systems to an incredible amount (again,
> that's something that seems really stupid to me since the
> $$ difference between 1GHz and 800MHz is not worth the
> potential damage; and the duron is up to 1.3GHz now....)

ok ... here so,e arguments why you could use this power-saving-patch:

1. my cpu is a xp 1600+ ... it is designed for around 56W power
consumption (as far as i know). his temperature is around 47°C under load.
and without the patch this temperatur and power consumptions is by no way
lesser, when he is idle. with the patch the temperature drops by around 10
°C and for the first time i noticed, that i have 2 temperature controlled
fans (cpu and psu fan) in my case. now he isnice quiet when there is no
realy load on it, and he only sounds like a hairdrier when he gets realy
somthing to do (ok ... when you  have seti running all the time, the patch
would not make any difference in poer consumption or temperature ... cause
the mashine is under load all the time)

2. power safing is a realy good idea generally !

3. that the amd cpu saves no power before u have activated this
bus-disconnect-function is a bug :) (as far as i know)

oh ...  by the way: i have not overclocked my computer ... i only want to
save a little bit of power, when my computer has nothing realy to do (only
surfing, mailing, programming) and i am glad that i now could have some
benefits from temperatur controlled fans (the noise level is much lesser
now)

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

