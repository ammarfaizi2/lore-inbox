Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276766AbRJ2RWM>; Mon, 29 Oct 2001 12:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276831AbRJ2RWC>; Mon, 29 Oct 2001 12:22:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30727 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276766AbRJ2RVu>; Mon, 29 Oct 2001 12:21:50 -0500
Subject: Re: eepro100.c & Intel integrated MBs
To: jurgen@botz.org (Jurgen Botz)
Date: Mon, 29 Oct 2001 17:29:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11361.1004374395@nova.botz.org> from "Jurgen Botz" at Oct 29, 2001 08:53:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yGDe-0003Lt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm now using the e100 driver from the Intel web site, which works
> perfectly, and light testing shows the Scyld (Don Becker) driver
> to work as well.  The Intel driver seems to have an incompatible
> license (noxious advertising clause?), but the Scyld drivers don't...
> at least there isn't any license mentioned and of course many=20
> of the net drivers in the current kernel are just earlier versions
> of the Scyld drivers.

Its not quite that simple - they are branches. If the Becker driver works
and the -ac driver doesn't then that is good news and it would be very
interesting to figure out which change mattered.

The -ac kernel on my i810/i815 boxes works reliably providing I dont turn
on the ACPI stuff
