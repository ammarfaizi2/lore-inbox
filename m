Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264414AbRFIAPW>; Fri, 8 Jun 2001 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264417AbRFIAPM>; Fri, 8 Jun 2001 20:15:12 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:36484 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264414AbRFIAPE>; Fri, 8 Jun 2001 20:15:04 -0400
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Chris Boot <bootc@worldnet.fr>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "L. K." <lk@aniela.eu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <20010608140553.C20944@alcove.wittsend.com> <200106082116.f58LGd2497562@saturn.cs.uml.edu> <20010608191600.A12143@alcove.wittsend.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 08 Jun 2001 20:13:01 -0400
In-Reply-To: "Michael H. Warfield"'s message of "Fri, 8 Jun 2001 19:16:00 -0400"
Message-ID: <m2iti67boy.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "MHW" == Michael H Warfield <mhw@wittsend.com> writes:
[snip]
 MHW> 	Yes, bits are free, sort of...  That's why an extra decimal
 MHW> place is "ok".  Keeping precision within an order of magnitude
 MHW> of accuracy is within the realm of reasonable.  Running out to
 MHW> two decimal places for this particular application is just
 MHW> silly.  If it were for calibrated lab equipment, fine.  But not
 MHW> for CPU temperatures.

You do introduce some rounding errors if the measurement isn't in
Celsius or Kelvin.  Ie, you must do a conversion because the hardware
isn't in the desired units.  In this case, the extra precision will be
beneficial.  

If you are going your route, you should send error bars with all the
measurements ;-) Fine, too many decimals leads to a false sense of
security.  However, no one knows the accuracy of any future
temperature sensors so why not accommodate the possibility.  Certainly
some band gap semis can give a pretty good measurement if you have
good coupling.  If the temperature sensor was built into the CPU, you
might actually have accuracy!

regards,
Bill Pringlemeir.

This thread keeps going and going and going...

