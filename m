Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274096AbRI3UR1>; Sun, 30 Sep 2001 16:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274097AbRI3URJ>; Sun, 30 Sep 2001 16:17:09 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:24496 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S274095AbRI3UQu>; Sun, 30 Sep 2001 16:16:50 -0400
Date: Sun, 30 Sep 2001 16:23:38 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Ookhoi <ookhoi@dds.nl>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: boot/root floppies in modern times?
In-Reply-To: <20010930185017.H9327@humilis>
Message-ID: <Pine.LNX.4.33.0109301559370.29482-100000@clubneon.clubneon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, Ookhoi wrote:

> I had the same problem with my vaio c1ve. Only a usb floppy drive, and
> no way to let it read the second floppy disk or to make it mount root
> via nfs as the nic got active after the bootp requests.

Well I got the e-mail from Alan Cox, thought it was a little terse, but it
did focus me on the initrd, went and read the initrd.txt again, and found
that Alan's e-mail spoke volumes.

Like Alan suggested I squeezed and I got lilo, the kernel, and an initrd
fs containing a static busybox on 1 floppy.

> I solved this by using one floppy with a initrd with enough tools to
> download the drivers which were not in the kernel (for example usb &
> scsi, or ide). You then just download the modules plus insmod on your
> ramdisk and of you go.

So, I ended up where you did, 1 floppy with enough tools to load any other
floppy with anything else I need.

Which brings me to my next stumbling block.  The NIC that I have now (got
an internal mini-pci one coming next week) is a PC Card.  That is
something else I've never messed with.  I built the driver (3c574) into
the kernel, but from what I'm seeing that isn't enough?  I also need the
pcmcia-cs userland tools?  (I'm reading the PCMCIA-HOWTO now.)  I guess
this wouldn't seem too strange to me if I was still running 2.2 and needed
the isapnp userland stuff, but that has been included in the kernel.  So
what is the deal with PC Cards?

Well I've got more reading to do.

Thanks again,
Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

