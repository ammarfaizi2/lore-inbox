Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVCNO2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVCNO2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVCNO2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:28:15 -0500
Received: from styx.suse.cz ([82.119.242.94]:45030 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261508AbVCNO2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:28:13 -0500
Date: Mon, 14 Mar 2005 15:28:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
Message-ID: <20050314142847.GA4001@ucw.cz>
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42357AE0.4050805@tls.msk.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 02:52:00PM +0300, Michael Tokarev wrote:
 
> After plugging in USB keyboard and loading uhci-hcd and
> usbhid, the keyboard un-freeze, but mouse still didn't
> work.  So I tried re-loading psmouse module, and
> surprizingly, mouse started working again, but now dmesg
> says:
> 
>  input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> 
> (normally it's
>  input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> )
> 
> and the mouse is moving very fast now.  Previously
> I either didn't able to make it work at all after such
> freeze, or it worked automatically after loading usbhid.
> 
> BTW, it's 2.6.10, I can't made it work with 2.6.11 at all.

Can you try 'usb-handoff' on the kernel command line?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
