Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVAaT1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVAaT1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAaT1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:27:06 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:31459 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261326AbVAaT0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:26:55 -0500
Date: Mon, 31 Jan 2005 20:27:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Blazejowski <diffie@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
Message-ID: <20050131192704.GD2972@ucw.cz>
References: <20050130130131.030c1ef1.akpm@osdl.org> <200501301831.25095.dtor_core@ameritech.net> <9dda3492050131110845b68cb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dda3492050131110845b68cb4@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 02:08:26PM -0500, Paul Blazejowski wrote:

> > > Begin forwarded message:
> > >
> > > Date: Sun, 30 Jan 2005 15:45:04 -0500
> > > From: Paul Blazejowski <diffie@gmail.com>
> > > To: Andrew Morton <akpm@osdl.org>
> > > Cc: LKML <linux-kernel@vger.kernel.org>
> > > Subject: Re: 2.6.11-rc2-mm2
> > >
> > >
> > > Here's another one, my USB keyboard is not functioning properly, ie.
> > > the caps lock,scrlk and num lock lights are not on when these keys are
> > > pressed and dmesg gets tons of spam for each key presses:
> > >
> > > drivers/usb/input/hid-input.c: event field not found
> > > drivers/usb/input/hid-input.c: event field not found
> > > drivers/usb/input/hid-input.c: event field not found
> > > drivers/usb/input/hid-input.c: event field not found
> > > drivers/usb/input/hid-input.c: event field not found
> > >
> > 
> > I this it was fixed in Vojtech tree, probably with the following patch:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110702712719062&q=raw
> 
> After applying the patch in above url, dmesg got quiet but the
> keyboard LED lights are still non functional.

I didn't notice that, I'll try toggling the LED lights.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
