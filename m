Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTIYHUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbTIYHSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:18:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51623 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261740AbTIYHSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:18:25 -0400
Date: Tue, 23 Sep 2003 14:23:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roger Luethi <rl@hellgate.ch>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Message-ID: <20030923122317.GB11901@openzaurus.ucw.cz>
References: <20030915224136.GA11666@k3.hellgate.ch> <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On some machines APIC (sic) support can cause this. Try turning off UP APIC
> > if you have it turned on.
> 
> If I turn off CONFIG_X86_UP_APIC I get:
> 
> | ACPI disabled because your bios is from 00 and too old
> | You can enable it with acpi=force
> | Sony Vaio laptop detected.
> 
> and ACPI is disabled. Halt doesn't work.
> 
> If I then pass _acpi=force' to explicitly enable ACPI, _halt' works again and
> powers off the machine, but _reboot' causes a black screen with IDE disk spun
> down, but no restart.

If acpi is actually usefull there, we might want to whitelist it.
Try other reboot methods...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

