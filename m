Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRDWUTj>; Mon, 23 Apr 2001 16:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDWUTa>; Mon, 23 Apr 2001 16:19:30 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:54234 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S131376AbRDWUTN>;
	Mon, 23 Apr 2001 16:19:13 -0400
Date: Mon, 23 Apr 2001 21:14:48 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl arg passing
In-Reply-To: <20010423195043.S682@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.21.0104232059190.7619-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser mentioned the following:

| On Mon, Apr 23, 2001 at 05:06:48PM +0100, Matt wrote:
| > I'm writing a char device driver for a dsp card that drives a motion
| > platform.
| 
| Can you elaborate on the dsp card? Is it freely programmable? I'm
| working on a project to support this kind of stuff via a
| dedicated subsystem for Linux.

AFAIK the card could be used for all sorts, but I'm not terribly
knowledgable about it as I've only been told how to program the thing with
respect to it's chosen application, ie. to drive the platform. It's got
analog and digital inputs/outputs, I don't know what else.

I'm writing this driver as part of my final year project at University,
and I'm working from the existing Windows code, so I'm not really exposed
to the cards internals at all.

The card is solely accessed through four consecutive I/O port address,
the first two control the address of ram on the card I want, and I read or
write to the second two. All accesses are 16-bit wide. That's as much as I
know really.

| The problem is, that it's hard to get access to such cards. So
| development is moving very slow :-(

My other problem is that I only have three/four weeks left to do as much
as possible, I've just managed to get my head 'round the Windows code so I
know how the code works, without having to fit it into some other grand
scheme of things.

I did try to write the driver with respect to making it nice and modular,
but without another card I can't work out what might be common to both
etc.

Once I've written the driver, I might be able to help merge it into some
other system, but atm my prority is to get it working as it is, so I can
at least get a good mark, I don't think I'm doing it a bad way, it's just
based heavily in structure on the existing Windows code.

Cheers

Matt

