Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278697AbRJ2R7m>; Mon, 29 Oct 2001 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRJ2R7c>; Mon, 29 Oct 2001 12:59:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4872 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278697AbRJ2R7Q>; Mon, 29 Oct 2001 12:59:16 -0500
Subject: Re: eepro100.c & Intel integrated MBs
To: greearb@candelatech.com (Ben Greear)
Date: Mon, 29 Oct 2001 18:05:56 +0000 (GMT)
Cc: jurgen@botz.org (Jurgen Botz), linux-kernel@vger.kernel.org
In-Reply-To: <3BDD8EEC.6DFE6BA5@candelatech.com> from "Ben Greear" at Oct 29, 2001 10:16:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yGnN-0003UO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Scyld drivers have only recently started working with the 2.4 series,
> and there is some unholly war between Becker and the rest of the kernel

Hardly that. Donald does things his way, and then other folks pick up his
changes where good (most of the time in fact) and merge them into the
kernel drivers.

If someone can figure why Don's driver sorts out the 815E hangs then thats
stuff we want in the main stream.

> instead of the eepro100.  The e100's license is close to compatible
> with the kernel, and I've heard rumors that the remaining issues may
> be worked out...  I've also heard the code is ugly as hell...but it

The patent grant thing got sort of sorted out (last I saw it was seems ok
now ask vendor legal people). Unfortunately it seems the intel people want
to force e100.c into the kernel by refusing to work on eepro100.c. 

As anyone can tell you trying to force things on Linux developers generally
works out pretty badly. Other bits of Intel are being quite sane (eg most
of the ACPI stuff except for the speedstop mobile stuff).

Alan

