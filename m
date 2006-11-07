Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754082AbWKGHPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbWKGHPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbWKGHPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:15:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40587 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754082AbWKGHPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:15:00 -0500
Date: Tue, 7 Nov 2006 08:14:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced up
Message-ID: <20061107071449.GB21655@elf.ucw.cz>
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106013153.GN15897@curie-int.orbis-terrarum.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [Please CC me on responses].
> 
> A spot of weirdness I ran into on my e1000 card.
> It's the 82566DC model [8086:104b] (rev 02) x1 PCIe.
> 
> After modprobe e1000, ethtool reports that there is no link, despite the
> correct link lights on the port. This breaks booting during a boot process that
> checks for actual link status before using a device.
...
> This behavior differs from every other network card, and is also present in the
> 7.3* version of the driver from sourceforge.
> 
> I think the e1000 should try to raise the link during the probe, so that it
> works properly, without having to set ifconfig ethX up first.

I think you should cc e1000 maintainers, and perhaps provide a patch....

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
