Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVCNQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVCNQZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVCNQZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:25:48 -0500
Received: from styx.suse.cz ([82.119.242.94]:33004 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261568AbVCNQZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:25:00 -0500
Date: Mon, 14 Mar 2005 17:25:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
Message-ID: <20050314162537.GA2716@ucw.cz>
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru> <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235B367.3000506@tls.msk.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 06:53:11PM +0300, Michael Tokarev wrote:
> Vojtech Pavlik wrote:
> >On Mon, Mar 14, 2005 at 02:52:00PM +0300, Michael Tokarev wrote:
> > 
> >
> >>After plugging in USB keyboard and loading uhci-hcd and
> >>usbhid, the keyboard un-freeze, but mouse still didn't
> >>work.  So I tried re-loading psmouse module, and
> >>surprizingly, mouse started working again, but now dmesg
> >>says:
> >>
> >>input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> >>
> >>(normally it's
> >>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> >>)
> >>
> >>and the mouse is moving very fast now.  Previously
> >>I either didn't able to make it work at all after such
> >>freeze, or it worked automatically after loading usbhid.
> >>
> >>BTW, it's 2.6.10, I can't made it work with 2.6.11 at all.
> >
> >
> >Can you try 'usb-handoff' on the kernel command line?
> 
> The problem has nothing to do with USB per se, as far as
> I can see.  PS2 keyboard and mouse does not work when
> the USB subsystem (incl. usbcore) is not loaded.  And the
> problem is with PS2 keyboard/mouse, not with USB one which
> works just fine.
 
Of course. Nevertheless 'usb-handoff' tells the BIOS not to meddle with
the PS/2 interfaces, too. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
