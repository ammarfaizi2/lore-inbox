Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSAWL41>; Wed, 23 Jan 2002 06:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSAWL4I>; Wed, 23 Jan 2002 06:56:08 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:50699 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S289811AbSAWLzs>; Wed, 23 Jan 2002 06:55:48 -0500
Date: Wed, 23 Jan 2002 12:55:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Timothy Covell <timothy.covell@ashavan.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Message-ID: <20020123125545.A5882@suse.cz>
In-Reply-To: <200201230512.g0N5CIr12742@home.ashavan.org.> <Pine.LNX.4.40.0201230814310.29728-100000@infcip10.uni-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0201230814310.29728-100000@infcip10.uni-trier.de>; from nofftz@castor.uni-trier.de on Wed, Jan 23, 2002 at 08:27:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 08:27:29AM +0100, Daniel Nofftz wrote:
> On Wed, 23 Jan 2002, Timothy Covell wrote:
> > 1. According to AMD specs, the model 3 Duron's don't
> > use more that 40 Watts maximum.
> >
> > 2. With my Duron 800 on a KT133A chipset
> > running folding@home and seti@home
> > continuously, LM sensors reports:
> >
> > SYS Temp: +45.2°C
> > CPU Temp: +35.1°C
> > SBr Temp: +25.8°C
> >
> >
> > So, I see absolutely no cause for alarm, nor even a need for
> > lvcool (esp. not when running seti@home).   And  I certainly
> > haven't seen any Athlon PSE/AGP lockups.  So, are you all
> > overclockng your systems to an incredible amount (again,
> > that's something that seems really stupid to me since the
> > $$ difference between 1GHz and 800MHz is not worth the
> > potential damage; and the duron is up to 1.3GHz now....)
> 
> ok ... here so,e arguments why you could use this power-saving-patch:
> 
> 1. my cpu is a xp 1600+ ... it is designed for around 56W power
> consumption (as far as i know). his temperature is around 47°C under load.
> and without the patch this temperatur and power consumptions is by no way
> lesser, when he is idle. with the patch the temperature drops by around 10
> °C and for the first time i noticed, that i have 2 temperature controlled
> fans (cpu and psu fan) in my case. now he isnice quiet when there is no
> realy load on it, and he only sounds like a hairdrier when he gets realy
> somthing to do (ok ... when you  have seti running all the time, the patch
> would not make any difference in poer consumption or temperature ... cause
> the mashine is under load all the time)
> 
> 2. power safing is a realy good idea generally !
> 
> 3. that the amd cpu saves no power before u have activated this
> bus-disconnect-function is a bug :) (as far as i know)
> 
> oh ...  by the way: i have not overclocked my computer ... i only want to
> save a little bit of power, when my computer has nothing realy to do (only
> surfing, mailing, programming) and i am glad that i now could have some
> benefits from temperatur controlled fans (the noise level is much lesser
> now)

Won't ACPI idle do that well enough?

-- 
Vojtech Pavlik
SuSE Labs
