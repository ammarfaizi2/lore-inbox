Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVFEJJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVFEJJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 05:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFEJJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 05:09:23 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:56216 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261175AbVFEJJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 05:09:18 -0400
Date: Sun, 05 Jun 2005 05:09:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
In-reply-to: <42A2A0B2.7020003@freemail.hu>
To: linux-kernel@vger.kernel.org
Message-id: <200506050509.16104.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <42A2A0B2.7020003@freemail.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 June 2005 02:50, Zoltan Boszormenyi wrote:
>Hi,
>
>$SUBJECT says almost all, system is MSI K8TNeo FIS2R,
>Athlon64 3200+, running FC3/x86-64. I use the multiconsole
>extension from linuxconsole.sf.net, the patch does not touch
>anything relevant under drivers/input or drivers/usb.
>
>The mice are detected just fine but the mouse pointers
>do not move on either of my two screens. The same patch
>(not counting the trivial reject fixes) do work on the
>2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
>keyboard and aux ports work correctly.
>
>I attached dmesg and the contents of /proc/interrupts.
>The interrupt count on USB does not increase if I move either
>mouse.
>
>Best regards,
>Zoltán Böszörményi

Not sure whats going on with your systems, Zoltan, but I'm running a 
M$ bluetooth optical RF mouse into a usb port, running 
2.6.12-rc5-git9 with no known gotchas.  Booted for about 8 hours now.

>From my dmesg:
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
...
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical 
Mouse® 1.0A] on usb-0000:00:02.1-2.1--

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
