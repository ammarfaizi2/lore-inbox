Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSLJQfC>; Tue, 10 Dec 2002 11:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLJQfC>; Tue, 10 Dec 2002 11:35:02 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:52486 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S263837AbSLJQfB>;
	Tue, 10 Dec 2002 11:35:01 -0500
Date: Tue, 10 Dec 2002 17:42:43 +0100
From: Martin Mares <mj@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021210164243.GA2915@ucw.cz>
References: <Pine.LNX.4.33.0212072046260.8470-100000@localhost.localdomain> <Pine.LNX.4.44.0212072018480.1103-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212072018480.1103-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

> Just out of interest, where _does_ it get the information? Does it try to
> do its own irq routing (bad!) or does it do it from /proc/bus/pci/devices?

The latter (unless you use `lspci -b' which reads the config registers
directly) and it's doing it this way since the first version ;)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Anything is good and useful if it's made of chocolate.
