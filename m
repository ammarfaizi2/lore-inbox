Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279949AbRKNB1p>; Tue, 13 Nov 2001 20:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279951AbRKNB1Z>; Tue, 13 Nov 2001 20:27:25 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:27652 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279949AbRKNB1U>;
	Tue, 13 Nov 2001 20:27:20 -0500
Message-Id: <5.1.0.14.0.20011114120201.02372220@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Nov 2001 12:27:14 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: What Athlon chipset is most stable in Linux?
Cc: "Calin A. Culianu" <calin@ajvar.org>,
        "Paul G. Allen" <pgallen@randomlogic.com>
In-Reply-To: <Pine.LNX.4.30.0111131738370.8219-100000@rtlab.med.cornell.
 edu>
In-Reply-To: <3BF19C23.F45EBB50@randomlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:39 PM 13/11/01 -0500, Calin A. Culianu wrote:
> > > Other AMD 761 boards may work, but I've made too many late night trips to
> > > the colo to stray from what I know works.  DDR support seems to be the
> > > breaking point on most boards.
> >
> > Another thing to remember about Athlons is they need power and cooling.
>
>Very true.  I think good numbers to shoot for are like around 40-50
>degrees C for the CPU temp, probably a bit lower for the M/B temp (like
>around high 30's?).

I get from 26-36 (Celsius) for the chipset, and 32-45 for the CPU at the 
moment. Average of 6-9 degrees difference between chipset and CPU. Main 
thing that changes this is ambient air temp, and not process load. I don't 
use APM or ACPI to put the cpu into power saving stuff in idle or shutting 
down drives or what not, so my temp stays quite stable.

Cases are in general badly designed, and do not allow for any decent 
airflow, wether convectional or forced. I've noticed this leading to all 
sorts of failure, particularly in hard drives, which do not like heat at 
all (and if someone could please shoot the nutcase at WD who started 
wrapping their drives in rubber cases.. I'd be immensely grateful *grin*). 
It's not too hard to augment some normal cases to have some decent airflow. 
Just make sure to turn off all the power saving features (APM, ACPI, etc) 
otherwise you won't get reliable results that you can compare against.

> > My dual 1.4GHz (K7 Thunder) has 12 fans in it. My single 1.4GHz has 8. 
> They both have 400W+ power supplies.

I'm running a 1.4Ghz fine with 4 x 80mm fans (really nice case with very 
good airflow - about 120cfm in my case - it's a rackmount 3RU case known as 
a Spinserver) and a 7000rpm fan on the CPU heatsink that has a copper core 
(in which almost all the air that goes through the case goes past the CPU 
heatsink). The m/board in this is an Asus A7M (AMD761 & Via 686b). Also in 
the damn thing is a GeForce3, SBLive! and a 3Com 3c905B, so they add to the 
extra juice draw (and the heat), and I run quite happily on a 300W PSU.

This system of mine was previously stable with 2.4.7, then 2.4.9, then it 
wouldn't work properly with anything till 2.4.14. Now I get great disk 
throughput, fast mem IO, and even better frame rates in OpenGL apps (using 
the binary Nvidia driver no less, telling it to use AGPgart) than any 
previous kernel. And it's the most stable system I've run as a user system 
(and I do hit it pretty hard sometimes).

And yeah, a user (desktop) machine in rackmount case may not make sense 
some people, but it's fine for me. *grin*


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

