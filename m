Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268674AbRHACuJ>; Tue, 31 Jul 2001 22:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269322AbRHACt7>; Tue, 31 Jul 2001 22:49:59 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:11277 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S268674AbRHACtu>;
	Tue, 31 Jul 2001 22:49:50 -0400
Date: Tue, 31 Jul 2001 21:03:45 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PCMCIA IDE_CS in 2.4.7
In-Reply-To: <20010801015116.B11060@win.tue.nl>
Message-ID: <Pine.LNX.4.10.10107312050460.25753-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Well, my plans to hack on a weird piece of hardware in order to
experiment with kernel hacking did not go as planned.  Seems the device
works fine without any problems at all.  (The device is the eFilm Reader-7
PCMCIA PCI card.)  The only "hacking" needed was to remove two bits of
plastic that kept me from inserting one card.

But in getting this installed, I found something that does not seem
right...

The module that used to be called "ide_cs.o" is now called "ide-cs.o".

It this on purpose or have I found a bug?

The reason I am wondering is that it requires some serious search and
replace in /etc/pcmcia/config to correct the problem or renaming the
module by hand. Not much of a hassle for me, but others will find it very
confusing.  (Especially since the rest of the card service modules seem to
use "_cs.o" instead of "-cs.o".)

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

