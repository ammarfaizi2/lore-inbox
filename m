Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVAAWxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVAAWxC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 17:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVAAWxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 17:53:02 -0500
Received: from gprs215-173.eurotel.cz ([160.218.215.173]:27266 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261194AbVAAWwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 17:52:53 -0500
Date: Sat, 1 Jan 2005 23:52:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050101225238.GA22388@elf.ucw.cz>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050101221722.GA28045@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050101221722.GA28045@butterfly.hjsoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > e100 seems to have some suspend/resume support [but if even reloading
> > e100 does not help, fault is not in e100]. Are you running with APIC
> > enabled? Try noapic. Try acpi=off.
> 
> it had been fine in 2.6.9.  i think i had switched to using apic back
> with 2.6.9 (to facilitate nmi_watchdog, maybe).
> 
> i'll try these options.  ultimately, though, i'm going to need acpi. :)

Ok, so if everything else fails, just find which changeset broke it
for you.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
