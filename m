Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVACWIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVACWIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACWIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:08:42 -0500
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:4032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261885AbVACWIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:08:11 -0500
Date: Mon, 3 Jan 2005 23:07:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 resuming laptop from suspension f*cks usb subsystem
Message-ID: <20050103220704.GB25250@elf.ucw.cz>
References: <41D2C4FA.7010806@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2C4FA.7010806@telefonica.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Apart from the timer drift thingie, 2.6.10 brought some new features 
> like usb devices (ramdomly) not working after resuming from suspend mode.
> 
> In 2.6.9 usb worked well, resuming from suspend just throws a bunch 
> (near 20) messages like:
> 
>    drivers/usb/input/hid-core.c: input irq status -84 received
> 
> (getting form /var/log/syslog, just don't have time to switch back to 
> 2.6.9 and fiddle with it again). After those messages, the usb subsystem 
> comes stable again and worked like a charm.
> 
> In 2.6.10, resuming from suspend mode just (randomly) crashes the USB 
> subsystem, and I get the same messages (not sure about the whole message 
> but the "-84" part really is there) over and over again until I reboot.

Does it still happen with noapic? 2.6.10 has some interrupt related
problems with APIC...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
