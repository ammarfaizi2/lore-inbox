Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCNQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCNQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVCNQd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:33:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:7876 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261575AbVCNQdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:33:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cs2c1s2jTddOH72ENyMkwK6jBX2X07BkvaLzSxxmEPciYv4YYdqnta2/DJBYGB2uYZWmLKOskn5Uk7Mni8NvcSBy22Dn7sf7j1Ma1TJrurCr0t6o2sP9qmKlslRqSBcK7VpcysmvDib7q79IUUmXjRMYcXTWotJtuz8CVY5siAs=
Message-ID: <d120d5000503140830e7daa72@mail.gmail.com>
Date: Mon, 14 Mar 2005 11:30:01 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: mouse&keyboard with 2.6.10+
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4235B367.3000506@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru>
	 <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 18:53:11 +0300, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Vojtech Pavlik wrote:
> > On Mon, Mar 14, 2005 at 02:52:00PM +0300, Michael Tokarev wrote:
> >
> >
> >>After plugging in USB keyboard and loading uhci-hcd and
> >>usbhid, the keyboard un-freeze, but mouse still didn't
> >>work.  So I tried re-loading psmouse module, and
> >>surprizingly, mouse started working again, but now dmesg
> >>says:
> >>
> >> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> >>
> >>(normally it's
> >> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> >>)
> >>
> >>and the mouse is moving very fast now.  Previously
> >>I either didn't able to make it work at all after such
> >>freeze, or it worked automatically after loading usbhid.
> >>
> >>BTW, it's 2.6.10, I can't made it work with 2.6.11 at all.
> >
> >
> > Can you try 'usb-handoff' on the kernel command line?
> 
> The problem has nothing to do with USB per se, as far as
> I can see.  PS2 keyboard and mouse does not work when
> the USB subsystem (incl. usbcore) is not loaded.  And the
> problem is with PS2 keyboard/mouse, not with USB one which
> works just fine.
> 

Nonetheless please try the option. If makes USB not interfere with PS/2 ports.

-- 
Dmitry
