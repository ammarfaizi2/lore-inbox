Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284240AbRL2QWa>; Sat, 29 Dec 2001 11:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284244AbRL2QWV>; Sat, 29 Dec 2001 11:22:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32017 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284240AbRL2QWO>; Sat, 29 Dec 2001 11:22:14 -0500
Subject: Re: [RFC,PATCH] x86 DMI scan and UP_APIC fixes
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Sat, 29 Dec 2001 16:32:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112291616.RAA10507@harpo.it.uu.se> from "Mikael Pettersson" at Dec 29, 2001 05:16:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KMPo-0004sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The x86 UP_APIC code breaks on some machines due to BIOS bugs,
> in particular on all recent Dell Inspiron and Latitude laptops.
> This is something the DMI scan could fix, but unfortunately
> the boot order is such that the DMI scan occurs long after much
> of the core hardware has been detected and initialised.

Agreed. Also it would help for some of the intel 440GX junk where we need
to force the UP APIC on to get the irq delivery working.

