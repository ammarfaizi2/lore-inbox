Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbSKKIkL>; Mon, 11 Nov 2002 03:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKKIkL>; Mon, 11 Nov 2002 03:40:11 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:20153 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S265978AbSKKIkK>; Mon, 11 Nov 2002 03:40:10 -0500
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
References: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
	<20021110233206.GA3988@win.tue.nl>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 11 Nov 2002 09:46:33 +0100
Message-ID: <wrpwunkfq8m.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20021110233206.GA3988@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <aebr@win.tue.nl> writes:

Andries> Is the database not very incomplete?

Well, it is about a thousand entries long, and I beleive it to be
fairly complete. There weren't *that* many EISA cards produced, anyway
:-).

Andries> What use is a very long and very incomplete list?

A big part of this database contains in fact ISA cards for which an
EISA config file exists. So it could be trimmed down to 50%, I think.
I was thinking the database could be useful for ISAPNP (since it uses
the same IDs).

Anyway, I don't really care about this list. It was just an effort to
mimic what the PCI code did for years, with a database that is 5 times
bigger, and still growing. At least with EISA, it won't be growing
that much... :-)

Andries> Just like for USB and PCI it might be more reasonable to
Andries> have such a list with IDs on a website instead of in the
Andries> kernel source?

If people are ready to give up this kind of thing, fair enough :

$ cat /sys/devices/pci0/00\:0c.0/name 
Digital Equipment Corporation DECchip 21140 [FasterNet]
$ cat /sys/devices/eisa/00\:05/name 
3Com EtherLink III Bus Master EISA (3C592) Network Adapter

But once again, the EISA list is not a big deal. I care about the core
code and the drivers, not the fancy naming. If it has to go, it will.

        M.
-- 
Places change, faces change. Life is so very strange.
