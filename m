Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVG3KJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVG3KJM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbVG3KJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:09:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9149 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263032AbVG3KJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:09:08 -0400
Date: Sat, 30 Jul 2005 12:06:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050730100658.GB1942@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I was finally able to get C3 state working. It seems that my BIOS is
> leaving USB controllers in an active state(?). Without any USB drivers
> loaded, C3 is not possible. With drivers loaded, but no device plugged
> in C3 works fine. Kernel is 2.6.13-rc3-mm3 + acpi-sbs.
> 
> With working C3 there are indeed differences:
> 
> Voltage is 16.5 V
> 
> HZ=100:  ~460 mA => 7.59 W
> HZ=250:  ~468 mA => 7.72 W
> HZ=1000: ~494 mA => 8.15 W

0.55W difference, wow. And that's 7% difference to overall system
consumption.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
