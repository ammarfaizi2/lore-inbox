Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAKMhm>; Thu, 11 Jan 2001 07:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAKMhc>; Thu, 11 Jan 2001 07:37:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28169 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129842AbRAKMh0>; Thu, 11 Jan 2001 07:37:26 -0500
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
To: cort@fsmlabs.com (Cort Dougan)
Date: Thu, 11 Jan 2001 12:38:21 +0000 (GMT)
Cc: jayts@bigfoot.com, andrewm@uow.edu.au (Andrew Morton),
        linux-kernel@vger.kernel.org (lkml),
        linux-audio-dev@ginette.musique.umontreal.ca (lad)
In-Reply-To: <20010110202224.C4624@hq.fsmlabs.com> from "Cort Dougan" at Jan 10, 2001 08:22:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ggzn-00028W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The darn thing disables intrs on its own for quite some time with some of
> the more aggressive drivers.  We saw our 20us latencies under RTLinux go up
> a lot with some of those drivers.

It isnt disabling interrupts. Its stalling the PCI bus. Its nasty tricks by
card vendors apparently to get good benchmark numbers.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
