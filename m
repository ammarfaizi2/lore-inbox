Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTITN6z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTITN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:58:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12555 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261891AbTITN6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:58:54 -0400
Date: Sat, 20 Sep 2003 15:58:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roger Luethi <rl@hellgate.ch>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Message-ID: <20030920135835.GB589@alpha.home.local>
References: <20030915224136.GA11666@k3.hellgate.ch> <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 03:17:37PM +0200, Geert Uytterhoeven wrote:
 
> If I turn off CONFIG_X86_UP_APIC I get:
> 
> | ACPI disabled because your bios is from 00 and too old
> | You can enable it with acpi=force
> | Sony Vaio laptop detected.
> 
> and ACPI is disabled. Halt doesn't work.
> 
> If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again and
> powers off the machine, but `reboot' causes a black screen with IDE disk spun
> down, but no restart.

Strangely, the problem you describe here what I got with local APIC enabled,
on a Vaio PCG-FX705 (athlon 1.3G). I think I will retry with a recent kernel
to be sure these problems vanished.

Regards,
Willy

