Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVHANJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVHANJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 09:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVHANJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 09:09:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:8407 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261608AbVHANJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 09:09:03 -0400
Date: Mon, 1 Aug 2005 15:09:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lee Revell <rlrevell@joe-job.com>, abonilla@linuxwireless.org,
       linux-kernel@vger.kernel.org,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       Yani Ioannou <yani.ioannou@gmail.com>, Dave Hansen <dave@sr71.net>
Subject: Re: IBM HDAPS, I need a tip.
Message-ID: <20050801130902.GA23949@ucw.cz>
References: <1122861215.11148.26.camel@localhost.localdomain> <1122872189.5299.1.camel@localhost.localdomain> <1122873057.15825.26.camel@mindpipe> <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr> <42EE1324.10304@grupopie.com> <Pine.LNX.4.61.0508010836020.30161@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508010836020.30161@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:55:53AM -0400, linux-os (Dick Johnson) wrote:

> > Jan Engelhardt wrote:
> >>> So in order to calibrate it you need a readily available source of
> >>> constant acceleration, preferably with a known value.
> >>>
> >>> Hint: -9.8 m/sec^2.
> >>
> >> Drop it out of the window? :)
> >
> > No, no. Constant gravity (like having the laptop sitting on the desk)
> > "feels like" constant acceleration.
> >
> > Dropping it out of the window should measure 0 m/sec^2, because the
> > accelerometer is not working on an inertial referential (I hope this is
> > the correct term in english...). For the accelerometer, this is just
> > like the feeling of free falling inside an elevator: no gravity :)
> >
> > --
> > Paulo Marques - www.grupopie.com
> 
> You need a centrifuge or something that works like one. You can
> make one and you can calibrate it using simple techniques.

Not at all. It's enough to let the laptop lie on the table for [0,0]G
calibration, then put sequentially it on all the four sides for [-1,0]G,
[1,0]G, [0,1]G, [0,-1]G calibration.

>From these five measurements you have both the zero point and the
slopes, including a good error estimate.

I've done that before when toying with IMUs.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
