Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313579AbSDQTWZ>; Wed, 17 Apr 2002 15:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313583AbSDQTWY>; Wed, 17 Apr 2002 15:22:24 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:9981 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S313579AbSDQTWW>; Wed, 17 Apr 2002 15:22:22 -0400
Date: Wed, 17 Apr 2002 12:20:26 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
 (take 2)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <07d501c1e644$ee62c6e0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that the relevance of the USB spec to most people is exactly 0%.

But to USB developers, if it's not 100% they're in major trouble!
They're the folk who will be using this terminology/API the most.

The challenge here is to come up with something that doesn't
needlessly confuse the major communities of interest ... such
as by redefining terms that are already in use.


> ... there is absolutely _no_ way a Linux "USB
> device driver" will ever mean that the driver turns the box into a USB
> device.

I tend to agree that the volume of such usage will outshout any
others, since a "device side" driver is mostly of interest to a
person doing embedded systems work.  (Or a PDA.)  Even
there, the scenario is to write one 


> Since we're talking about the other end of a "host" driver, "client" makes
> sense - in computers, I've always seen "client" as the reverse of the
> "host", but maybe that's just me. 

Another overloaded word.  I've always seen it as the requestor,
in all contexts (restaurants, stores, networking ... :) and in USB
it's the "host" that requests.


> What were the other suggestions?

Of the two I saw coming by this morning ("target" from Larry,
and "gadget" from Stephen) I confess I liked "target" best.
It captures the initating/responding roles quite well.

I don't recall many other suggestions that were forthcoming.

But I'll also toss out "firmware", which is often used in such
contexts:  firmware revision for a network adapter, and so on.
"USB firmware" is not likely to be expected on the host side.
"USB target firmware", and so on.

- Dave



