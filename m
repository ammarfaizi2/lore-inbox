Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVC3PAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVC3PAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVC3PAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:00:32 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:50193 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261923AbVC3PA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:00:27 -0500
Date: Wed, 30 Mar 2005 17:00:23 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Message-ID: <20050330150023.GB6878@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <2a0fbc59050325145935a05521@mail.gmail.com> <1111792462.23430.25.camel@mindpipe> <20050329185825.GB20973@irc.pl> <1112128807.5141.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112128807.5141.14.camel@mindpipe>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 03:40:07PM -0500, Lee Revell wrote:
> On Tue, 2005-03-29 at 20:58 +0200, Tomasz Torcz wrote:
> > On Fri, Mar 25, 2005 at 06:14:22PM -0500, Lee Revell wrote:
> > > On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > > > - audio works too. The only problem is that two applications can't
> > > > open /dev/dsp in the same time.
> > > 
> > > Not a problem.  ALSA does software mixing for chipsets that can't do it
> > > in hardware.  Google for dmix.
> > > 
> > > However this doesn't (and can't be made to) work with the in-kernel OSS
> > > emulation (it works fine with the alsa-lib/libaoss emulation).  So you
> > 
> >  quake3 still segfaults when run through "aoss". And can't be fixed, as
> > it's closed source still.
> > 
> I guess that's Quake3's problem...

 It an glaring example, dmix is unsufficient in one third of my sound
uses (other two beeing movie and music playback)
 But you advertise dmix like it was silver bullet.

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray

