Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAELaK>; Fri, 5 Jan 2001 06:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbRAELaB>; Fri, 5 Jan 2001 06:30:01 -0500
Received: from server.cdi.cz ([194.213.254.2]:65039 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S129736AbRAEL3x>;
	Fri, 5 Jan 2001 06:29:53 -0500
Posted-Date: Fri, 5 Jan 2001 12:29:36 +0100
Date: Fri, 5 Jan 2001 12:29:35 +0100 (CET)
From: Devik <devik@server.cdi.cz>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Network oddity.... 
In-Reply-To: <200101050008.BAA14222@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.10.10101051218200.5989-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting,
yesterday I have TCP problems with my three independent systems.
They all acts as simple firewalls with MASQ. Yesterday they all
suddenly stopped responding to ssh TCP connections to IP on eth1 
(internal net) but they continued to work on IP attached to eth0 
and lo. The problem survived reboot. Then it suddenly ceased and 
I can't trigger it again.
Kernels was 2.2.13, 2.2.16 and 2.2.17 and the systems was
completely unrelated.
Kind of woodoo or what ...
devik


> Oh, this situation seems to continue: it sends a syn-ack and then the
> client replies with a reset. This goes on and on. I'm going to make
> the client disappear, and hope that this makes the number of these
> connections go away.
> 
> Kernel is 2.2.13. That was "fresh" when the system was booted. Yes,
> that's over 14 months ago. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
