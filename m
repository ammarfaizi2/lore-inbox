Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUAONcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUAONcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:32:14 -0500
Received: from dotnetslash.net ([66.199.224.19]:45830 "EHLO
	mail.dotnetslash.net") by vger.kernel.org with ESMTP
	id S265061AbUAONcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:32:12 -0500
Date: Thu, 15 Jan 2004 08:32:10 -0500
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: BIOS Flash changes PowerNOW frequencies?
Message-ID: <20040115133209.GB6819@dotnetslash.net>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20040111175610.GA26855@dotnetslash.net> <20040115120300.GA12963@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115120300.GA12963@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 01:03:00PM +0100, Pavel Machek wrote:
> Hi!
> 
> > I'm not currently subscribed. Please cc: me on responses.
> > 
> > I'm running 2.6.0 on an HP Pavilion ze4420 Athlon version (lspci -v
> > below).  I recently flashed the BIOS (hoping against all odds for
> > suspend to ram capability) and the CPU frequencies discovered by
> > PowerNOW (K7) has changed.  This is obviously caused by the BIOS
> > update, but the stupid question of the day is "Why?". If the CPU and
> > chipset support both sets of frequencies with different BIOS,
> > wouldn't the _real_ set of supported frequencies be the union of the
> > 2?
> 
> Well, maybe the chipset does not properly support it after all?

Well, properly or not, everything I tested short of detailed benchmarking
since -test3 has had no problems and always reported stats fine.

> Anyway, you might want to simply implant old tables into kernel, and
> use them... Possibly even doing union.

Thanks. I vaguely remember trying something like this, for a completely
different and forgotten issue, when I first started playing with ACPI.
It turned out to not be necessary so that file has been erased from my
memory and apparently over-written too much to be recovered.

It seems the new BIOS has also given me better backlight and IDE
power saving support (translation watching DVD's while on battery now
sucks). It seems as if I'm going to have to become an ACPI expert to get
some control over what this thing's doing and when. Like, it suspends
fine in Windows but not in Linux. (Actually, it suspends fine in Linux
too - It just won't wake up.) Can you point me to some references that
will help be build my own tables without burning my machine up?

> Pavel
> --
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

And I've been puzzling over your sig since I first saw it. I still
don't get it and it's driving me nuts.... When you have 13-15 high card
points and 5 strong hearts?

mwa
-- 
Mark W. Alexander
slash@dotnetslash.net
