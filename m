Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVADVve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVADVve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVADVtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:49:14 -0500
Received: from mail.tmr.com ([216.238.38.203]:43023 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262268AbVADVq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:46:26 -0500
Date: Tue, 4 Jan 2005 16:23:06 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050104205513.GU2708@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1050104161415.3306A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, William Lee Irwin III wrote:

> On Tue, Jan 04, 2005 at 09:34:44PM +0100, Adrian Bunk wrote:
> > <--  snip  -->
> > config BLK_DEV_UB
> >         tristate "Low Performance USB Block driver"
> >         depends on USB
> >         help
> >           This driver supports certain USB attached storage devices
> >           such as flash keys.
> > 
> >           If unsure, say N.
> > <--  snip  -->
> > Call me naive, but at least for me it wouldn't have been obvious that 
> > this option cripples the usb-storage driver.
> > The warning that this option cripples the usb-storage driver was added 
> > after people who accidentially enabled this option ("it can't harm") 
> > in 2.6.9 swamped the USB maintainers with bug reports about problems 
> > with their storage devices.
> 
> The "it can't harm" assumption was flawed. Minimal configs are best for
> a reason. Inappropriate options turned on can and always will be able
> to take down your box and/or render some devices inoperable.

And if the user actually wants to use a flash key reader on his/her
system? Is it all that naive to turn on this option? What option would a
knowlegible user employ? Or do such readers peruse the entire kernel
source so they know that using the key reader will disable storage divices
on their USB? 

But I did make the point that this was fixed quickly, insofar as adding
"this will kill storage devices on USB" to the config constitutes a fix.
If it killed the CD burner I would have caught this myself, I only use the
attached disk for major backup... 

The idea that you would even imply that people turning this option on were
naive users, or that it would be done for no good reason, seems pretty far
from the truth in this case.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

