Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVBRNgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVBRNgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRNgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:36:05 -0500
Received: from mail1.kontent.de ([81.88.34.36]:24015 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261352AbVBRNgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:36:04 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 14:36:01 +0100
User-Agent: KMail/1.7.1
Cc: Richard Purdie <rpurdie@rpsys.net>, Vojtech Pavlik <vojtech@suse.cz>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
References: <20050213004729.GA3256@stusta.de> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz>
In-Reply-To: <20050218132651.GA1813@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502181436.01943.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> and it will not work on i386/APM, anyway. I still believe right
> solution is to add input interface to ACPI. /proc/acpi/events needs to
> die, being replaced by input subsystem.

But aren't there power events (battery low, etc) which are not
input events?

	Regards
		Oliver

