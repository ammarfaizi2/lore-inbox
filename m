Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVAARZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVAARZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 12:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVAARZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 12:25:29 -0500
Received: from gprs215-210.eurotel.cz ([160.218.215.210]:31360 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261156AbVAARZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 12:25:24 -0500
Date: Sat, 1 Jan 2005 18:23:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050101172344.GA1355@elf.ucw.cz>
References: <20041228144741.GA2969@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041228144741.GA2969@butterfly.hjsoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> similarly to other people reports of hardware troubles after swsusp, my
> thinkpad r40's e100 nic doesn't fully function after resume.
> 
> ifplugd can see the link status change when i plug and unplug the cable,
> but the dhclient it runs just tries and retries to get an ip without
> success.
> 
> i've tried reloading e100, mii, and even af_packet, but only a reboot
> fixes it.

e100 seems to have some suspend/resume support [but if even reloading
e100 does not help, fault is not in e100]. Are you running with APIC
enabled? Try noapic. Try acpi=off.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
