Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279884AbRK0OpF>; Tue, 27 Nov 2001 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRK0Ooz>; Tue, 27 Nov 2001 09:44:55 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:58779 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S279902AbRK0Oot>; Tue, 27 Nov 2001 09:44:49 -0500
Date: Tue, 27 Nov 2001 15:43:23 +0100
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011127154323.B513@Zenith.starcenter>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva> <9tu0n2$sav$1@cesium.transmeta.com> <20011126192902.M5770@khan.acc.umu.se> <3C028A8D.8040503@zytor.com> <20011126161802.A8398@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126161802.A8398@xi.linuxpower.cx>; from greg@linuxpower.cx on Mon, Nov 26, 2001 at 04:18:02PM -0500
X-Operating-System: Linux 2.4.16
X-Telephone: +32 486 460306
X-Requested: Beautiful, smart and Linux-lovin' girlfriend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 04:18:02PM -0500, Gregory Maxwell wrote:
> Why not just disguard this sillyness of alphabetic characters in version
> numbers... Just carry through the same structure used by major/minor:
> I.e.
> 
> 2.0.39 < released 2.0.39
> 2.0.39.1.1 < first development snapshot of the kernel which will eventually
> 	     be 2.0.40
> 2.0.39.1.2 < second
> 2.0.39.1.n < Nth
> 2.0.39.2.1 < first RC
> 2.0.39.2.2 < second RC
> 2.0.39.3.1 < opps! Development went too long and we had to break feature
> 	     freeze to add important features.
> 2.0.39.4.1 < Trying to stablize again
> 2.0.39.4.2 < a few more bugs fixxed
> 2.0.40	   < Looks like 2.0.39.4.2 got it right!

Some people may find this more "logical", but imho most will find it
confusing... It's already difficult to inform someone about the
(number).(even|odd).(release)-(patch|pre-final) scheme. I'm more into 
	-pre: added some features, bugfixes etc...
	-fc : feature-freeze, only bugfixes
and having some time (f.i. 48h) between the last -fc and the "real" release
(without having a single addendum to the ChangeLog).

Just my 2 cents,
	Sven Vermeulen

-- 
Some people have told me they don't think a fat penguin really embodies
the grace of Linux, which just tells me they have never seen a angry
penguin charging at them in excess of 100mph. They'd be a lot more
careful about what they say if they had. ~(Linus Torvalds)

