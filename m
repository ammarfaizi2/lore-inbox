Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272062AbTG2U3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272048AbTG2U3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:29:17 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:16768 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272062AbTG2U3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:29:11 -0400
Date: Tue, 29 Jul 2003 21:38:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds an abstraction layer for programmable LED devices,
> > hardware drivers for the Status LEDs found on some Intel PIIX4E based
> > server hardware (notably the ISP1100 1U rackmount server) and LEDs wired
> > to the parallel port data lines.
>
> I haven't had chance to test this yet, but I really like the idea - by
> an amasing co-incidence, I was actually thinking about the possibility
> of doing a parallel port connected front panel earlier today!
>
> Does anybody have any suggestions for recommended standard uses for
> parallel port connected LEDs?
>
> Disk spinning up/disk ready
> Root login active
>
> Any other suggestions?

Ah, I just thought, for debugging purposes we could have LEDs for:

* BKL taken
* Servicing interrupt
* Kernel stack usage > 2K

John.
