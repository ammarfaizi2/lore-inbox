Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbTBXABH>; Sun, 23 Feb 2003 19:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269044AbTBXABH>; Sun, 23 Feb 2003 19:01:07 -0500
Received: from [195.208.223.248] ([195.208.223.248]:17536 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S269041AbTBXABG>; Sun, 23 Feb 2003 19:01:06 -0500
Date: Mon, 24 Feb 2003 03:10:57 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       ink@jurassic.park.msu.ru, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030224031057.A611@localhost.park.msu.ru>
References: <20030223173441.D20405@flint.arm.linux.org.uk> <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com> <20030223193229.F20405@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030223193229.F20405@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Feb 23, 2003 at 07:32:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 07:32:29PM +0000, Russell King wrote:
> Alan kindly sent one of these beasts to me, which renewed my interest
> in this area.  I'll forward stuff so far.

If you're talking the Mobility things, I certainly wouldn't mind to
have one ;-) - this stuff isn't available here in Moscow, I did check...

> I'd like to hear Gregs comments first - Greg knows the hotplugging code
> better than me.

Ditto.

> We need to wait until everything is setup for step 4 because we may
> (and do in the case of this split-bridge) need to program PCI-PCI
> bridges before the devices become accessible.

At a glance I agree with your patch.

Ivan.
