Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289070AbSANVWd>; Mon, 14 Jan 2002 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSANVVg>; Mon, 14 Jan 2002 16:21:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289062AbSANVT3>; Mon, 14 Jan 2002 16:19:29 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 14 Jan 2002 21:30:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), zippel@linux-m68k.org (Roman Zippel),
        yodaiken@fsmlabs.com, phillips@bonn-fries.net (Daniel Phillips),
        arjan@fenrus.demon.nl (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <3C43497C.2609D55@zip.com.au> from "Andrew Morton" at Jan 14, 2002 01:11:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QEgq-00031Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, that's my point.  A well-designed DVD player would have two processes.
> One which tangles with the sockets, pipes, disks, etc, and which feeds data into
> and out of the SCHED_FIFO task via a shared, mlocked memory region.
> 
> What I'm trying to develop here is a set of guidelines which will allow
> application developers to design these programs with a reasonable
> degree of success.

What about the X server 8)

Given 1mS and vague fairness DVD is more than acceptable
