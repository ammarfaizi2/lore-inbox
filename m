Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRCEUOn>; Mon, 5 Mar 2001 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbRCEUOd>; Mon, 5 Mar 2001 15:14:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2821 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130406AbRCEUOX>; Mon, 5 Mar 2001 15:14:23 -0500
Subject: Re: NE2000 problem
To: g.anzolin@inwind.it (Gianluca Anzolin)
Date: Mon, 5 Mar 2001 20:17:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, becker@webserv.gsfc.nasa.gov
In-Reply-To: <20010305211104.A383@fourier.home.intranet> from "Gianluca Anzolin" at Mar 05, 2001 09:11:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a1QD-0007gg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	IRQ:		5
> 	I/O ports:	0x320-0x32f
> 	HW MAC:		55:AA:44:32:39:41
> 
> (the MAC is strange, the other cards I have begin all with 00)

The mac address is broken. 55/AA is a common test pattern funnily enough. As
it has a multicast address it wont work.
