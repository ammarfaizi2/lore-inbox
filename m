Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVGGVdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVGGVdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVGGVbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:31:43 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28857 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261781AbVGGV2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:28:36 -0400
Date: Thu, 7 Jul 2005 23:28:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050707212855.GA2871@ucw.cz>
References: <20050707193027.GA4162@inferi.kami.home> <20050707200238.52898.qmail@web81308.mail.yahoo.com> <20050707212442.GA4054@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707212442.GA4054@inferi.kami.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:24:43PM +0200, Mattia Dongili wrote:
> On Thu, Jul 07, 2005 at 01:02:38PM -0700, Dmitry Torokhov wrote:
> > Mattia Dongili <malattia@gmail.com> wrote:
> [...]
> > > This is the device (on a Vaio GR), which other info could I provide to
> > > better diagnose the problem?
> > > 
> > 
> > Could you please do "echo 1 > /sys/modules/i8042/parameters/debug";
> > reload psmouse module and send me dmesg please?
> 
> oh, it seems I'm not able to reproduce the error anymore!
> I need some rest now, I'll try again tomorrow morning (I must be missing
> something stupid right now) and report to you again.
 
Could be the enabled debug is adding extra delay, making the problem
impossible to reproduce. IIRC, we've seen this with an ALPS pad, too,
Dmitry, right?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
