Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbVBDO47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbVBDO47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVBDO46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:56:58 -0500
Received: from styx.suse.cz ([82.119.242.94]:5763 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S263149AbVBDO4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:56:42 -0500
Date: Fri, 4 Feb 2005 15:57:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Blazejowski <diffie@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
Message-ID: <20050204145701.GA2311@ucw.cz>
References: <20050130130131.030c1ef1.akpm@osdl.org> <200501301831.25095.dtor_core@ameritech.net> <9dda3492050131110845b68cb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dda3492050131110845b68cb4@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 02:08:26PM -0500, Paul Blazejowski wrote:
> On Sun, 30 Jan 2005 18:31:24 -0500, Dmitry Torokhov
> <dtor_core@ameritech.net> wrote:
> > On Sunday 30 January 2005 16:01, Andrew Morton wrote:
> > >
> > > Did someone break usb input?
> > >
> > >
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
> > 
> > --
> > Dmitry
> > 
> 
> After applying the patch in above url, dmesg got quiet but the
> keyboard LED lights are still non functional.

Should be fixed in rc3. It was yet another bug.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
