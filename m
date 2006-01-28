Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWA1Imf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWA1Imf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 03:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWA1Imf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 03:42:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24282 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751319AbWA1Ime (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 03:42:34 -0500
Date: Sat, 28 Jan 2006 09:42:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060128084225.GC1605@elf.ucw.cz>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127232207.GB1617@elf.ucw.cz> <20060128013111.GA30225@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128013111.GA30225@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If vbetool's primary purpose is to fix video after suspend/resume,
> > then perhaps right thing to do is to integrate it into s2ram and
> > maintain it there.
> 
> That's the primary purpose, though there's a couple of edge cases. 
> For VBE state saving/restoring, it seems to be important to save the 
> state before X has started rather than doing so at suspend time - some 
> i855 systems break otherwise.

Well, doing it at boot is slightly ugly; I'd like s2ram to just work,
and not need boot-time-hooks. [If there's no other solution... what
can I do, but I do not like it.]

> Not strictly related - Pavel, try taking a look at the acpi-support 
> package in http://archive.ubuntu.com/ubuntu/pool/main/a/acpi-support/ . 
> There's a large list of witelisted hardware there. OSDL recently set
> up 

Thanks for pointer! Anyway, AFAICT the list is not really adequate. It
lists working machines, but does not really list all the switches
neccessary to get the video working. (Well, it tries in some cases,
*strange*, perhaps less switches are neccessary than I think?)

> a mailing list (desktop-portables@lists.osdl.org) for cross-distribution 
> laptop discussion. It would probably be helpful to discuss working 
> machines there, rather than duplicate the whitelisting efforts.

I'm afraid I don't have a time for another mailing list, and this
should not be really related to the desktop...
							Pavel
-- 
Thanks, Sharp!
