Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131533AbRCNUq2>; Wed, 14 Mar 2001 15:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131537AbRCNUqT>; Wed, 14 Mar 2001 15:46:19 -0500
Received: from candygarden.jaj.com ([209.64.26.39]:31755 "EHLO
	disaster.jaj.com") by vger.kernel.org with ESMTP id <S131533AbRCNUqG>;
	Wed, 14 Mar 2001 15:46:06 -0500
Date: Wed, 14 Mar 2001 15:58:01 -0500
From: Phil Edwards <pedwards@disaster.jaj.com>
To: linux-kernel@vger.kernel.org
Subject: State of RAID (and the infamous FastTrak100 card)
Message-ID: <20010314155801.A7054@disaster.jaj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am not subscribed at the moment (don't ask :), so please cc me.]

A few months ago there was a brief discussion about the FastTrak100 card
and the driver that Promise provides, and just what all can (technically)
be done.  It eventually became a debate about what may (legally) be done
with the driver, and then turned into another "what the GPL /really/
says" thread.  :-)

I've just read all those messages from the archives.  And I've been
skimming the RAID-related HOWTOs at linuxdoc.org, but many seem out of date.
One in particular starts off by saying that the stock 2.2 support is buggy,
and that the "new" version is much improved, but requires patches and a
rebuild, and is still alpha code.  Of course, the doc saying it's alpha
is itself a year old.

The MAINTAINERS and Documentation/* files don't mention the FastTrack100
(not surprising, it's not OSS) nor software RAID (also unsurprising,
it's software).


So... am I just begging for pain if I try to install, say, a stock RH7
on a machine with the FastTrak100 doing it's little RAID0/JBOD thing?
If it requires this machine to always boot from a floppy because the driver
cannot be linked into the kernel, well, I'm okay with that.

RH7 ships with 2.2.16.  Is building a new 2.2.18 kernel just going to
shoot me in the head with this card (and Promise's proprietary driver)?

What's the state of RAID in the 2.4 kernels?

I'm very leery of solutions that involve lots of patches to the 2.2.x kernel,
because I have to have a working system in order to rebuild a kernel... and
I would have to patch the kernel before I can install/boot the system... and
there will be no other hard drives available in the machine; just the two
being striped (or glued) by the FastTrak100 Card of Doom.


Much thanks,
Phil

-- 
pedwards at disaster dot jaj dot com  |  pme at sources dot redhat dot com
devphil at several other less interesting addresses in various dot domains
The gods do not protect fools.  Fools are protected by more capable fools.
