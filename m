Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318417AbSGaRkZ>; Wed, 31 Jul 2002 13:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318420AbSGaRkZ>; Wed, 31 Jul 2002 13:40:25 -0400
Received: from www.transvirtual.com ([206.14.214.140]:45581 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318417AbSGaRkY>; Wed, 31 Jul 2002 13:40:24 -0400
Date: Wed, 31 Jul 2002 10:43:40 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs and tty layer.
In-Reply-To: <20020731183957.B18153@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207311043020.13905-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jul 31, 2002 at 10:37:15AM -0700, James Simmons wrote:
> >    As you already seen there has been a issue with devfs and the VT code.
> > I have moved the tty registeration later for VTs so the TTY_DRIVER_NO_DEVFS
> > flag was no longer needed.
>
> It's needed for serial.  Please don't remove it just yet.

I have no intention to have TTY_DRIVERS_NO_DEVFS removed. I just don't
need it anymore for VTs.

