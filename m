Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLAPGB>; Fri, 1 Dec 2000 10:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLAPFv>; Fri, 1 Dec 2000 10:05:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129226AbQLAPFm>; Fri, 1 Dec 2000 10:05:42 -0500
Subject: Re: watchdog software
To: oles@ovh.net (octave klaba)
Date: Fri, 1 Dec 2000 14:34:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A27B04B.1A628ADE@ovh.net> from "octave klaba" at Dec 01, 2000 03:06:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141rHA-0000In-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > my question is:
> > > what kind of problem can have this serveur:
> > > hardware or software ?
> > 
> > What sort of watchdog are you using ?
> 
> software. no hardware solution.
> http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/watchdog-5.1.tar.gz

The software watchdog will fail if the kernel is badly mashed or interrupts
are disabled. That means it doesn't help tell me if the problem was hardware
or software (nor in general do hardware watchdogs). Is this one box running
different loads to the others or different in any notable way ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
