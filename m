Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVADTiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVADTiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVADTfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:35:36 -0500
Received: from mail.tmr.com ([216.238.38.203]:6159 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261811AbVADTHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:07:44 -0500
Date: Tue, 4 Jan 2005 13:44:14 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rahul Karnik <deathdruid@gmail.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <5b64f7f0501040931699220ad@mail.gmail.com>
Message-ID: <Pine.LNX.3.96.1050104133518.2324D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Rahul Karnik wrote:

> On Mon, 3 Jan 2005 18:42:24 -0500 (EST), Bill Davidsen <davidsen@tmr.com> wrote:
> > On Mon, 3 Jan 2005, Horst von Brand wrote:
> > > > APM vs. ACPI - shutdown doesn't reliably power down about half of the
> > > > machines I use, and all five laptops have working suspend and non-working
> > > > resume. APM seems to be pretty unsupported beyond "use ACPI for that."
> > >
> > > Many never machines just don't have APM.
> > 
> > What's your point? I'm damn sure there are more machines with APM than 386
> > CPUs, AHA1540 SCSI controllers, or a lot of other supported stuff. Most
> > machines which have APM at all have a functional power off capability,
> > which is a desirable thing for most people.
> 
> The point is not that the kernel should not support APM because it is
> superceded by ACPI, but that your laptops do not support APM properly.
> Did they work correctly with APM in 2.4? If so, we have a regression;
> otherwise complain to the laptop vendor, they do not consider APM to
> be a high enough priority.
> 

The ThinkPad, Toshiba, and both Dells work correctly for both shutdown and
suspend (via the apm -s) using 2.4. I haven't tried the ACER, it's new and
started life with FC2 and a 2.6 kernel. It does power down correctly, and
suspend, but doesn't resume so it's not very useful.

I would complain with details, but the older laptops are now out of
production, so I am not going to ask someone to divert time to making
things work on them. The ACER is my current ride along, I would like to
suspend that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

