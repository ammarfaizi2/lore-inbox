Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKNUIe>; Wed, 14 Nov 2001 15:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRKNUIY>; Wed, 14 Nov 2001 15:08:24 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:12688 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S277165AbRKNUIH>;
	Wed, 14 Nov 2001 15:08:07 -0500
Date: Wed, 14 Nov 2001 15:08:07 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Stuart Young <sgy@amc.com.au>
Cc: <linux-kernel@vger.kernel.org>, "Paul G. Allen" <pgallen@randomlogic.com>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <5.1.0.14.0.20011114120201.02372220@mail.amc.localnet>
Message-ID: <Pine.LNX.4.30.0111141507180.16252-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Stuart Young wrote:

> At 05:39 PM 13/11/01 -0500, Calin A. Culianu wrote:
> > > > Other AMD 761 boards may work, but I've made too many late night trips to
> > > > the colo to stray from what I know works.  DDR support seems to be the
> > > > breaking point on most boards.
> > >
> > > Another thing to remember about Athlons is they need power and cooling.
> >
> >Very true.  I think good numbers to shoot for are like around 40-50
> >degrees C for the CPU temp, probably a bit lower for the M/B temp (like
> >around high 30's?).
>
> I get from 26-36 (Celsius) for the chipset, and 32-45 for the CPU at the
> moment. Average of 6-9 degrees difference between chipset and CPU. Main
> thing that changes this is ambient air temp, and not process load. I don't
> use APM or ACPI to put the cpu into power saving stuff in idle or shutting
> down drives or what not, so my temp stays quite stable.
>
> Cases are in general badly designed, and do not allow for any decent
> airflow, wether convectional or forced. I've noticed this leading to all
> sorts of failure, particularly in hard drives, which do not like heat at
> all (and if someone could please shoot the nutcase at WD who started
> wrapping their drives in rubber cases.. I'd be immensely grateful *grin*).
> It's not too hard to augment some normal cases to have some decent airflow.
> Just make sure to turn off all the power saving features (APM, ACPI, etc)
> otherwise you won't get reliable results that you can compare against.

Yes, true.  At least while testing out your cooling setup, it helps to
have the cpu heating up as much as it can.  That pesky 'hlt'
instruction... :)

 >
> > > My dual 1.4GHz (K7 Thunder) has 12 fans in it. My single 1.4GHz has 8.
> > They both have 400W+ power supplies.
>
> I'm running a 1.4Ghz fine with 4 x 80mm fans (really nice case with very
> good airflow - about 120cfm in my case - it's a rackmount 3RU case known as
> a Spinserver) and a 7000rpm fan on the CPU heatsink that has a copper core
> (in which almost all the air that goes through the case goes past the CPU
> heatsink). The m/board in this is an Asus A7M (AMD761 & Via 686b). Also in
> the damn thing is a GeForce3, SBLive! and a 3Com 3c905B, so they add to the
> extra juice draw (and the heat), and I run quite happily on a 300W PSU.
>
> This system of mine was previously stable with 2.4.7, then 2.4.9, then it
> wouldn't work properly with anything till 2.4.14. Now I get great disk
> throughput, fast mem IO, and even better frame rates in OpenGL apps (using
> the binary Nvidia driver no less, telling it to use AGPgart) than any
> previous kernel. And it's the most stable system I've run as a user system
> (and I do hit it pretty hard sometimes).
>
> And yeah, a user (desktop) machine in rackmount case may not make sense
> some people, but it's fine for me. *grin*
>
>
> AMC Enterprises P/L    - Stuart Young
> First Floor            - Network and Systems Admin
> 3 Chesterville Rd      - sgy@amc.com.au
> Cheltenham Vic 3192    - Ph:  (03) 9584-2700
> http://www.amc.com.au/ - Fax: (03) 9584-2755
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

