Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUBMEGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 23:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266711AbUBMEGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 23:06:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:18658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266706AbUBMEGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 23:06:52 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <2181.4.5.45.142.1076645210.squirrel@www.osdl.org>
Date: Thu, 12 Feb 2004 20:06:50 -0800 (PST)
Subject: Re: getting usb mass storage to finish before running init?
To: <der.eremit@email.de>
In-Reply-To: <E1ArSm1-0003ei-Pv@localhost>
References: <1oAMR-6St-13@gated-at.bofh.it>
        <E1ArSm1-0003ei-Pv@localhost>
X-Priority: 3
Importance: Normal
Cc: <spam99@2thebatcave.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 13 Feb 2004 03:00:21 +0100, you wrote in linux.kernel:
>
>> I can put a sleep in there but that is sloppy, and can not really be
>> relied apon (since technically there is no way I can know how long the
>> detection phase will take), and also I may be waisting time (which I
>> don't want to, I want a fast booting router).
>
> Check available devices for root filesystem (in case you're booting from
> IDE). If it's not there, wait a moment, then look for additional
> devices. If nothing shows up, repeat.

That's basically what my usb-boot patch for 2.4.22 does:
  http://www.xenotime.net/linux/usb/usbboot-2422.patch

I haven't tried to port it to 2.6.x.
---
~Randy



