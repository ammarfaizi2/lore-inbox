Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVCNPxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVCNPxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCNPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:53:49 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:52050 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261555AbVCNPxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:53:16 -0500
Message-ID: <4235B367.3000506@tls.msk.ru>
Date: Mon, 14 Mar 2005 18:53:11 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru> <20050314142847.GA4001@ucw.cz>
In-Reply-To: <20050314142847.GA4001@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Mon, Mar 14, 2005 at 02:52:00PM +0300, Michael Tokarev wrote:
>  
> 
>>After plugging in USB keyboard and loading uhci-hcd and
>>usbhid, the keyboard un-freeze, but mouse still didn't
>>work.  So I tried re-loading psmouse module, and
>>surprizingly, mouse started working again, but now dmesg
>>says:
>>
>> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
>>
>>(normally it's
>> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
>>)
>>
>>and the mouse is moving very fast now.  Previously
>>I either didn't able to make it work at all after such
>>freeze, or it worked automatically after loading usbhid.
>>
>>BTW, it's 2.6.10, I can't made it work with 2.6.11 at all.
> 
> 
> Can you try 'usb-handoff' on the kernel command line?

The problem has nothing to do with USB per se, as far as
I can see.  PS2 keyboard and mouse does not work when
the USB subsystem (incl. usbcore) is not loaded.  And the
problem is with PS2 keyboard/mouse, not with USB one which
works just fine.

/mjt
