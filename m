Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbQKERvC>; Sun, 5 Nov 2000 12:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQKERuw>; Sun, 5 Nov 2000 12:50:52 -0500
Received: from [212.115.175.146] ([212.115.175.146]:50160 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129734AbQKERuq>; Sun, 5 Nov 2000 12:50:46 -0500
Message-ID: <27525795B28BD311B28D00500481B7601623D7@ftrs1.intranet.FTR.NL>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "'Robert M. Love'" <rml@tech9.net>
Cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: RE: i82808 hardware hub RNG
Date: Sun, 5 Nov 2000 18:54:35 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wrote a daemon that fetches (as root-user) random numbers from the RNG
in
> the i82808 (found on 815-chipsets).
> You can download it from http://www.vanheusden.com/Linux/random.php3 .
> Currently, I'm trying to rewrite things into a kernel-module so that one
has
> a standard character device which can deliver random values then.
> Please give it a try as I do not own a PC with such a motherboard ;-/
RML> a driver for this already exists in 2.4 and was recently back-ported to
RML> 2.2. it works on i810, i815, and i820. it features a char device for
RML> grabbing entropy and a timer device to inject the entropy directly into
RML> /dev/random.
RML> Jeff Garzik wrote it.

Excellent!
Got any URLs?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
