Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281018AbRKCTO5>; Sat, 3 Nov 2001 14:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281019AbRKCTOs>; Sat, 3 Nov 2001 14:14:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281018AbRKCTOg>; Sat, 3 Nov 2001 14:14:36 -0500
Subject: Re: [khttpd-users] khttpd vs tux
To: tlussnig@bewegungsmelder.de (Thomas Lussnig)
Date: Sat, 3 Nov 2001 19:21:04 +0000 (GMT)
Cc: roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org,
        khttpd-users@zgp.org (khttpd mailing list)
In-Reply-To: <3BE44096.2070808@bewegungsmelder.de> from "Thomas Lussnig" at Nov 03, 2001 08:08:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1606Lo-0006ZD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on this hardware i think that the problem is the that the Kernel and
> Webserver need to suport that ( each of the 1Gbit card is bound to its
> own process and on Multiprozessor machine that the prozess is fixed to
> one CPU to minimize the siwtch overhead, also im not firm with the 
> FibreChannel2

Each GigE card will need its own 66MHz PCI bus. Each PCI bridge will need
to be coming off a memory bus that can sustain all of these and the CPU
at once.

At that point it really doesnt look much like a PC.

