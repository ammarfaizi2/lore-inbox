Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJYUsQ>; Thu, 25 Oct 2001 16:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276318AbRJYUsG>; Thu, 25 Oct 2001 16:48:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22532 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276312AbRJYUsA>; Thu, 25 Oct 2001 16:48:00 -0400
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Thu, 25 Oct 2001 21:54:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bcrl@redhat.com (Benjamin LaHaise),
        _deepfire@mail.ru (Samium Gromoff), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110252234270.27907-100000@tux.rsn.bth.se> from "Martin Josefsson" at Oct 25, 2001 10:40:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wrWY-0006EJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I upgraded that machine to pIII 700 and even that machine slows to a
> crawl while transmitting with that bloody ISA NE2K. It's the same thing in
> kernel 2.4 too. These days I simply don't use that card anymore...
> 
> So something seems to have taken a wrong turn between 2.0 and 2.2
> I don't think this is a problem intruduced in 2.4.

A faster machine will take as long as a slow machine with an ne2000. It
doesn't matter if its an 8Mb 386 or a dual athlon, it will spend almost all
of its ne2000 handling time poking bytes across an 8MHz bus.

