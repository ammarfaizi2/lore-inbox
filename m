Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVGHFkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVGHFkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVGHFkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:40:00 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:61112 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262612AbVGHFj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:39:59 -0400
Date: Fri, 8 Jul 2005 07:40:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050708054021.GA3224@ucw.cz>
References: <20050707212855.GA2871@ucw.cz> <20050707213958.84153.qmail@web81309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707213958.84153.qmail@web81309.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 02:39:58PM -0700, Dmitry Torokhov wrote:
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Thu, Jul 07, 2005 at 11:24:43PM +0200, Mattia Dongili wrote:
> > > On Thu, Jul 07, 2005 at 01:02:38PM -0700, Dmitry Torokhov wrote:
> > > > Mattia Dongili <malattia@gmail.com> wrote:
> > > [...]
> > > > > This is the device (on a Vaio GR), which other info could I provide to
> > > > > better diagnose the problem?
> > > > > 
> > > > 
> > > > Could you please do "echo 1 > /sys/modules/i8042/parameters/debug";
> > > > reload psmouse module and send me dmesg please?
> > > 
> > > oh, it seems I'm not able to reproduce the error anymore!
> > > I need some rest now, I'll try again tomorrow morning (I must be missing
> > > something stupid right now) and report to you again.
> >  
> > Could be the enabled debug is adding extra delay, making the problem
> > impossible to reproduce. IIRC, we've seen this with an ALPS pad, too,
> > Dmitry, right?
> 
> It was just a tad different - on one of the boxes alps-resume-typo
> patch worked only with debug. 2 other boxes worked just fine without
> debug.
> 
> I just can't see what could be wrong with ps2_adjust_timeout()...
> It only reduces timeout to 100 ms when doing reset, exactly like
> the old code did. Vojtech, can you see anything there?
 
No, I don't. I'll keep looking, though.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
