Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbQKERsv>; Sun, 5 Nov 2000 12:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQKERsl>; Sun, 5 Nov 2000 12:48:41 -0500
Received: from zero.tech9.net ([209.61.188.187]:29700 "EHLO tech9.net")
	by vger.kernel.org with ESMTP id <S129708AbQKERs1>;
	Sun, 5 Nov 2000 12:48:27 -0500
Date: Sun, 5 Nov 2000 12:48:24 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: Re: i82808 hardware hub RNG
In-Reply-To: <27525795B28BD311B28D00500481B7601623D5@ftrs1.intranet.FTR.NL>
Message-ID: <Pine.LNX.4.21.0011051246470.11627-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, Heusden, Folkert van hissed:
> I wrote a daemon that fetches (as root-user) random numbers from the RNG in
> the i82808 (found on 815-chipsets).
> You can download it from http://www.vanheusden.com/Linux/random.php3 .
> Currently, I'm trying to rewrite things into a kernel-module so that one has
> a standard character device which can deliver random values then.
> Please give it a try as I do not own a PC with such a motherboard ;-/

a driver for this already exists in 2.4 and was recently back-ported to
2.2. it works on i810, i815, and i820. it features a char device for
grabbing entropy and a timer device to inject the entropy directly into
/dev/random.

Jeff Garzik wrote it.

i am using it in 2.4 on my i815.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
