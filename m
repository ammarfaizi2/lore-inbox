Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVDDOxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDDOxq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDDOxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:53:46 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:28295 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261254AbVDDOxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:53:45 -0400
Date: Mon, 4 Apr 2005 10:53:39 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <200504031231.j33CVtHp021214@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Apr 2005, Mikael Pettersson wrote:

> Well, first step is to try w/o ACPI. ACPI is inherently fragile
> and bugs there can easily explain your timer problems. Either
> recompile with CONFIG_ACPI=n, or boot with "acpi=off pci=noacpi".


When I boot without ACPI (I used 'acpi=off pci=noacpi') the system fails
to come up all the way; it hangs after loading the SATA driver. (but
before the SATA driver finishes probing the disks)

I'm guessing that the interrupt from the SATA controller is not getting
through? Anyway, I assumed that ACPI was basically required for x86_64
systems to work, is this not really the case?


Thanks,

Chris
wingc@engin.umich.edu
