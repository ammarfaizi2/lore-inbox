Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVCGGZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVCGGZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVCGGZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:25:49 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:29658 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261649AbVCGGZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:25:28 -0500
Date: Mon, 7 Mar 2005 07:26:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Treat ALPS mouse buttons as mouse buttons
Message-ID: <20050307062611.GA1684@ucw.cz>
References: <422BA727.1030506@engr.orst.edu> <20050307055019.GA1541@ucw.cz> <422BF0B0.3030109@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BF0B0.3030109@engr.orst.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 10:12:00PM -0800, Micheal Marineau wrote:

> >>The following patch changes the ALPS touchpad driver to treat some mouse
> >>buttons as mouse buttons rather than what appears to be joystick buttons.
> >>This is needed for the Dell Inspiron 8500's DualPoint stick buttons. Without
> >>this patch only the touchpad buttons behave properly.
> > 
> > 
> > Thanks for the patch. I'll try to put this change into my the latest
> > version of the ALPS driver, which, unfortunately, has been reworked
> > significantly.
> > 
> > Can you send me the output of /proc/bus/input/devices on your machine?
> > I'd like to know the ID of your ALPS dualpoint.
> 
> I just looked at the new version in 2.6.11-mm1 and it appears that my
> change as already been covered in different ways and I'm not having any
> problem with the buttons on mm1.

Good. I just noticed the same. :)

> Just in case you still want to know,
> the following is the ouptput if /proc/bus/input/devices.
> 
> I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
> N: Name="AT Translated Set 2 keyboard"
> P: Phys=isa0060/serio0/input0
> H: Handlers=kbd
> B: EV=120013
> B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
> B: MSC=10
> B: LED=7
> 
> I: Bus=0011 Vendor=0002 Product=0008 Version=0000
> N: Name="AlpsPS/2 ALPS TouchPad"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0
> B: EV=f
> B: KEY=420 0 670000 0 0 0 0 0 0 0 0
> B: REL=3
> B: ABS=1000003

Thanks. Could you also attach the one from -mm1? It's a bit different.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
