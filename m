Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVITPBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVITPBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVITPBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:01:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32144 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965025AbVITPBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:01:50 -0400
Date: Fri, 16 Sep 2005 18:28:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: (BUG?) ACPI fails to suspend
Message-ID: <20050916162834.GA2307@openzaurus.ucw.cz>
References: <432A8377.4050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432A8377.4050209@gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> after:
> 
> echo shutdown > /sys/power/disk
> echo disk > /sys/power/state
> 
> i get:
> 
> Could not suspend device 0000:00:0a.2: error -22
> 
> 0000:00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI 
> USB 1.1 Controller (rev 50)
> 0000:00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI 
> USB 1.1 Controller (rev 50)
> 0000:00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
> 
> it's a pci usb 2.0 card. no active device plugged there.
> 
> the bad thing is that i can't suspend.
> the good thing is that kernel is safe, i can still work with it, 
> without panic or other troubles.

What happens if you try without usb2 support?
If it works, complain on usb list.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

