Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129856AbQKGA3Q>; Mon, 6 Nov 2000 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbQKGA3H>; Mon, 6 Nov 2000 19:29:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129856AbQKGA2y>; Mon, 6 Nov 2000 19:28:54 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jas88@cam.ac.uk (James A. Sutherland)
Date: Tue, 7 Nov 2000 00:27:03 +0000 (GMT)
Cc: goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <00110700192100.00940@dax.joh.cam.ac.uk> from "James A. Sutherland" at Nov 07, 2000 12:18:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13swbR-0006pk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> changing settings. If I plug in a hotplug soundcard and load the driver, I do
> NOT want the driver to decide to set some settings. If I want settings set,
> I'll do it myself (or have a script to do it).

How about if your stuff is already nicely set up and you remove then replug
a device, or remove and swap for an identical replacement part. Most people then
want the configuration preserved.

And guess what the simple modutils solution using an ELF section solves that too
Want to go to default configuration ?

	rm /var/run/modules/eth0.data

or wrap it in a GUI.

[BTW windows gets the USB speaker state management right, seems they store all
the module persistent data in the registry!]


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
