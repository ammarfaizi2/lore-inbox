Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVFTVbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVFTVbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFTV2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:28:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5339 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261617AbVFTV0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:26:08 -0400
Date: Mon, 20 Jun 2005 23:25:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050620212553.GA2222@elf.ucw.cz>
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz> <20050620204533.GA9520@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620204533.GA9520@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I don't think they have anything in the BIOS related to the HDAPS, else they
> > > > would have put something in it. (You can't even disable the chip in the
> > > > BIOS) I just think is the accelerometer, there, by itself with an extra card
> > > > they added.
> > >  
> > > Well, some piece of software needs to park the HDD when the notebook is
> > > falling, and that piece of software should better be running since the
> > > notebook is powered on. Hence my suspicion it's in the BIOS. It doesn't
> > > have to be visible to the user, at all.
> > 
> > Actually yes, it needs to be visible to the user and no, it probably
> > should not run during boot.  If user is in plane/train,
> > accellerometers will basically detect problems all the time; still you
> > want to use the computer.
> 
> It likely won't. What it does is that it detects a situation with no
> gravity - free fall.

IIRC it is more complicated than that. Free fall is too late, laptop
usually fall from 1meter. Thats not enough time to park the
heads. Fortunately, laptop usually tilts before it falls off the table
-- and they are measuring the tilt before the fall. That buys them
enough time to actually do anything with it.

Story says, that they once had version that worked from 2meters+. It
was kind of useless, because no laptop ever fell from that height and
those that did were destroyed anyway.

[ s = a t ^ 2.
  s = ~1m.
  a = 9.8m*s^-2.

  t = sqrt( s/a )
  t = 
ucalc> (1 m / (9.8 * (m * sec ^ (-2)))) ^ 0.5
OK:  0.319438  sec

...ouch, it should be way faster, 0.3sec is definitely enough to park
heads.]

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
