Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTIQKc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 06:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTIQKc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 06:32:56 -0400
Received: from gprs151-26.eurotel.cz ([160.218.151.26]:40068 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262714AbTIQKbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 06:31:42 -0400
Date: Wed, 17 Sep 2003 12:31:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Message-ID: <20030917103135.GL1205@elf.ucw.cz>
References: <20030916200655.GG602@elf.ucw.cz> <Pine.GSO.4.21.0309171120290.3644-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309171120290.3644-100000@vervain.sonytel.be>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> > > w.r.t. power management:
> > >   - It doesn't poweroff anymore (screen contents are still there after the
> > >     powering down message)
> > >   - It doesn't reboot anymore (screen goes black, though)
> > >   - It accidentally suspended to RAM once while I was actively working on it (I
> > >     never managed to get suspend working, except for this `accident'). I didn't
> > >     see any messages about this in the kernel log.
> > 
> > It suspended to RAM... Did it also *resume* correctly?
> 
> Yes, since I could continue working without problems (except for lost Ethernet,
> solved by ifdown -a/ifup -a).

And was that acpi or apm? If it was acpi you saw a little miracle.

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
