Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311405AbSCMW1Z>; Wed, 13 Mar 2002 17:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311407AbSCMW1P>; Wed, 13 Mar 2002 17:27:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13832 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311405AbSCMW1B>; Wed, 13 Mar 2002 17:27:01 -0500
Subject: Re: IO-APIC -- lockup on machine if enabled
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Wed, 13 Mar 2002 22:41:59 +0000 (GMT)
Cc: davej@suse.de, fryman@cc.gatech.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200203132052.VAA08581@harpo.it.uu.se> from "Mikael Pettersson" at Mar 13, 2002 09:52:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lHRX-0007fR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.5.6 has the original version of the patch kit, which includes the
> workarounds for Dell laptops but doesn't include the newer blacklist
> rules for the Thinkpad T20 and the MSI-6163.

BTW does 2.5.6 have the VIA/AMD one in it (See the AMD76x errata about
what happens if you mix AMD north and VIA south bridges with APIC mode)

> 2.4.19-pre3 has the relevant core changes, but lacks the actual DMI
> rules and local APIC workarounds. I believe the -ac versions also
> only include the core changes.

If there is stuff you think I should have feed me updates
