Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRCKOYE>; Sun, 11 Mar 2001 09:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRCKOXy>; Sun, 11 Mar 2001 09:23:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14604 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131424AbRCKOXi>; Sun, 11 Mar 2001 09:23:38 -0500
Subject: Re: HP Vectra XU 5/90 interrupt problems
To: jw2357@hotmail.com (John William)
Date: Sun, 11 Mar 2001 14:26:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F27mQVuRWCy7rjcxtni00003e70@hotmail.com> from "John William" at Mar 11, 2001 04:27:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14c6na-00005y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So PCI interrupts must always be level triggered? If so, then the kernel 
> should never program the IO APIC to use an edge triggered interrupt on a PCI 
> device. If that's true, then why not force the interrupt type to level 
> triggered for all PCI devices (to work around a potentially broken MP 
> table)?

Its not that simple. Its common to edge trigger some of the built in devices
like IDE controllers.

