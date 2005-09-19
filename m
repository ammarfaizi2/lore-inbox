Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVISPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVISPRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVISPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 11:17:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34246 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932460AbVISPRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 11:17:03 -0400
Date: Mon, 19 Sep 2005 14:16:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mike Mohr <akihana@gmail.com>
Cc: michal@harddata.com, linux-kernel@vger.kernel.org
Subject: Re: Reboot & ACPI suspend Laptop display initialization
Message-ID: <20050919121622.GA2317@elf.ucw.cz>
References: <4746469c0509161157bc762bc@mail.gmail.com> <20050916201457.GA29516@ellpspace.math.ualberta.ca> <4746469c05091622163e81dbea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4746469c05091622163e81dbea@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This isn't just a problem with ACPI's suspend.  If I reboot the
> machine, without without power management, the screen isn't properly
> reinitialized.  The problem with the suspend is certainly an issue
> with ACPI; however, the reboot issue probably isn't.  Unless someone
> can enlighten me?

Well, the reboot issue is broken BIOS... It should reset the hardware
when you are rebooting.

Read Doc*/power/video.txt for suspend issues.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
