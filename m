Return-Path: <linux-kernel-owner+w=401wt.eu-S1762508AbWLJUVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762508AbWLJUVk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762514AbWLJUVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:21:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:48842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762508AbWLJUVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:21:39 -0500
X-Authenticated: #20450766
Date: Sun, 10 Dec 2006 21:21:37 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Tilman Schmidt <tilman@imap.cc>
cc: Corey Minyard <cminyard@mvista.com>, linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
In-Reply-To: <20061210201438.tilman@imap.cc>
Message-ID: <Pine.LNX.4.60.0612102117590.9993@poirot.grange>
References: <4533B8FB.5080108@mvista.com> <20061210201438.tilman@imap.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006, Tilman Schmidt wrote:

> On Mon, 16 Oct 2006 11:53:15 -0500, Corey Minyard <cminyard@mvista.com> wrote:
> > This is a set of three patches to allow adding another driver on top of
> > the current serial driver without too much change to the serial code.
> > This is more for comments right now, it is probably not ready for real
> > use yet.

[snip]

> Has anything ever come of this? I would be very much interested in it.
> It might make it possible to extend the Siemens Gigaset drivers
> (drivers/isdn/gigaset) to the RS232 attached M101 DECT adapter.
> There is a working driver out of tree which accesses the serial port
> hardware directly (i8250 only), but that kind of thing doesn't seem
> fit for inclusion in the kernel.

...FWIW I would also gladly remove 
arch/powerpc/platforms/embedded6xx/ls_uart.c 
in favour of a standard interface to drivers/serial.

Thanks
Guennadi
---
Guennadi Liakhovetski
