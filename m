Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSCTOOP>; Wed, 20 Mar 2002 09:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSCTOOF>; Wed, 20 Mar 2002 09:14:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47881 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288012AbSCTONy>; Wed, 20 Mar 2002 09:13:54 -0500
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
To: macro@ds2.pg.gda.pl
Date: Wed, 20 Mar 2002 14:29:10 +0000 (GMT)
Cc: Martin.Wilck@fujitsu-siemens.com (Martin Wilck),
        pavel@suse.cz (Pavel Machek), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.GSO.3.96.1020320121631.13532A-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Mar 20, 2002 02:27:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nh5S-0002NW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Depending on the configuration -- a user may specify "notsc" for whatever
> reason (although admittedly, that's mostly a debugging option).

Mixed multiplier x86 for one - I've got some basic code there to handle
this automatically but its not yet finished. Plenty of BP6 folks have
mismatched celewrongs

> no need to keep it enabled unconditionally and I/O cycles are quite
> expensive.  The following patch implements it.  Please test it.  It should
> cure your problems as a side effect, but that does not mean the BIOS isn't
> to be fixed.

The DMI strings for that bios version would be useful to so that we can
panic with a "BIOS upgrade required" message
