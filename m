Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131428AbQLIW7V>; Sat, 9 Dec 2000 17:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132341AbQLIW7L>; Sat, 9 Dec 2000 17:59:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27143 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131428AbQLIW67>; Sat, 9 Dec 2000 17:58:59 -0500
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
To: hwm@ns.newportharbornet.com (Bob Lorenzini)
Date: Sat, 9 Dec 2000 22:29:45 +0000 (GMT)
Cc: jmerkey@vger.timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012091400590.17164-100000@newportharbornet.com> from "Bob Lorenzini" at Dec 09, 2000 02:03:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144sV1-0005pB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > and attempts to display the penguin images on the screen.  It 
> > renders the anaconda installer dead in the water when you attempt 
> > even a text mode install (not graphics) of a 2.2.18-25 kernel (and 24)
> > on a DELL laptop.  Is there a way to turn on frame buffer without 
> > kicking the kernel into mode 274 and killing DELL laptops during
> > a text based install?

Are you including the ATI frame buffer code or not - I assume yes.
> 
> Jeff the change that broke or first broke is in 2.2.17-15 if thats any help.

2.2.17pre15
o	ATI video fixes for PPC				(Benjamin Herrenschmidt)

So if thats the one that does it perhaps you can go over it with the powerpc
folks ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
