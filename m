Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136097AbRDVNCR>; Sun, 22 Apr 2001 09:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136096AbRDVNCF>; Sun, 22 Apr 2001 09:02:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136095AbRDVNBW>; Sun, 22 Apr 2001 09:01:22 -0400
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
To: dusty@strike.wu-wien.ac.at
Date: Sun, 22 Apr 2001 14:02:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kkeil@suse.de (Karsten Keil),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AE2D4E7.4D7E58BD@violin.dyndns.org> from "Hermann Himmelbauer" at Apr 22, 2001 02:56:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJVY-0005nY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/sys/kernel/print_apic_errors
> This would simply disable those "APIC error" kernel logs, so that the
> logfile is not flooded. (45000 log entries in 1 hour are quite a lot).
> Anyway once you know that your board has this problem, IMHO there is no
> further use in those messages.

'My computer is broken, please dont tell me'. At 45,000 an hour you are asking
to get real problems.

> /proc/sys/kernel/enable_apic
> The second one would enable/disable the APIC code for testing purposes -
> like the "noapic" parameter during boottime. But as I have no knowledge
> about those kernel internals, perhaps this wish is impossible to
> implement...

That one is actually very tricky to do. The decision is made at boot time and
rather hard to flip between them.

Alan

