Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265625AbUEZPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265625AbUEZPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUEZPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:49:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:60582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265625AbUEZPtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:49:24 -0400
Date: Wed, 26 May 2004 08:38:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Zenaan Harkness <zen@freedbms.net>
Cc: debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: drivers DB and id/ info registration
Message-Id: <20040526083859.418e42fa.rddunlap@osdl.org>
In-Reply-To: <1085573236.2213.77.camel@zen8100a.freedbms.net>
References: <1085542706.2908.25.camel@zen8100a.freedbms.net>
	<20040526065447.GA32304@dat.etsit.upm.es>
	<200405260918.51589@fortytwo.ch>
	<1085566079.2522.54.camel@zen8100a.freedbms.net>
	<1085571316.906.3.camel@localhost>
	<1085573236.2213.77.camel@zen8100a.freedbms.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 22:07:17 +1000 Zenaan Harkness wrote:

| On Wed, 2004-05-26 at 21:35, Wouter Verhelst wrote:
| > Op wo 26-05-2004, om 12:07 schreef Zenaan Harkness:
| > > I develop widget X.
| > > 
| > > I contact microsoft and have X incorporated into windows.

I think that most companies do it themselves (or pay to have
it done) for Windows drivers, if their devices don't fit into
some well-known interface.

For Linux drivers, it means finding the right group/project,
if it exists...  Could be hard to find at times.

| > Rotfl.
| 
| OK, bad assumption.
| 
| The only reason I say that is that so many devices work
| "seamlessly" with MSW*
| 
|  - recently I read a review on the X-Arcade retro joystick
| controllers (those heavy "for cabinets and MAME" things).
| The reviewer just plugged it in and Windows literally popped
| up with a dialog telling the "end user recognizable" name of
| the device.
| 
|  - a year or so back, my brother bought a "blue eye" USB
| external 2.5" HDD (really nice looking thing) and on his
| XP box it auto added a new drive (E: or whatever). Seamless.
| 
| So how come devices tend to just plug and play when
| used with Windows (USB HDDs, audi cards, logitec gear)?
| 
| Will a "visible"/ centralized location where manufacturers
| can submit info on their devices (for free software kernels)
| help to get us closer to the "front line" of device support?

I hear this way too much, for 2 reasons.

(a) You are right, we want to get to that model in Linux.

(b) The thing that bugs me (I guess) and that people seem to
overlook again and again is that Linux developers are not
provided the same access to hardware interface specs that other
driver developers have.  That leaves reverse engineering or
trial-and-error (mostly error).  That's an awful way to write
a driver IMO.  So to me it's just a specs issue, and many
companies won't or cannot provide product specs (often because
they don't own the IP inside the product, sometimes because
they _assume_ that it might aid their competition).

--
~Randy
