Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292315AbSBUKVa>; Thu, 21 Feb 2002 05:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292324AbSBUKVU>; Thu, 21 Feb 2002 05:21:20 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:55196 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292315AbSBUKVI>; Thu, 21 Feb 2002 05:21:08 -0500
Date: Thu, 21 Feb 2002 12:10:23 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <3C74C8C7.25D7BCD@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202211209050.7649-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:

> Zwane Mwaikambo wrote:
> > Thanks, but i think i wasted my time on this one, there is a driver for
> > most of the SC1200 bits (including watchdog) at http://www.nano-system.com/scx200
> 
> I just looked at their watchdog driver -- yours might be better...  They
> don't use semaphores in _open, they don't use request_region, etc.
> 
> Of course, OTOH their include list is smaller and they don't use
> MOD_{INC,DEC}_USE_COUNT ;-)

Well those other minors are now taken care of, but they also have the 
added advantage of having real hardware to test it out on ;)

Cheers,
	Zwane Mwaikambo


