Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUATOEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUATOEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:04:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30364 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265511AbUATOEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:04:46 -0500
Date: Thu, 15 Jan 2004 22:24:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: BIOS Flash changes PowerNOW frequencies?
Message-ID: <20040115212454.GH5770@openzaurus.ucw.cz>
References: <20040111175610.GA26855@dotnetslash.net> <20040115120300.GA12963@elf.ucw.cz> <20040115133209.GB6819@dotnetslash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115133209.GB6819@dotnetslash.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Anyway, you might want to simply implant old tables into kernel, and
> > use them... Possibly even doing union.
> 
> Thanks. I vaguely remember trying something like this, for a completely
> different and forgotten issue, when I first started playing with ACPI.
> It turned out to not be necessary so that file has been erased from my
> memory and apparently over-written too much to be recovered.
> 
> It seems the new BIOS has also given me better backlight and IDE
> power saving support (translation watching DVD's while on battery now
> sucks). It seems as if I'm going to have to become an ACPI expert to get
> some control over what this thing's doing and when. Like, it suspends
> fine in Windows but not in Linux. (Actually, it suspends fine in Linux
> too - It just won't wake up.) Can you point me to some references that
> will help be build my own tables without burning my machine up?
>

Hack the powernow-k7 driver, but make it
panic at the end. When it produces same messages as it did with old bios, you can be reasonably sure
you did it right and remove the panic.
 
> > --
> > When do you have a heart between your knees?
> > [Johanka's followup: and *two* hearts?]
> 
> And I've been puzzling over your sig since I first saw it. I still
> don't get it and it's driving me nuts.... When you have 13-15 high card
> points and 5 strong hearts?

Another hint is that you can actually do it in public, but you usually
do that outside of town.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

