Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292319AbSBUKQB>; Thu, 21 Feb 2002 05:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292315AbSBUKPu>; Thu, 21 Feb 2002 05:15:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11790 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291666AbSBUKPi>;
	Thu, 21 Feb 2002 05:15:38 -0500
Message-ID: <3C74C8C7.25D7BCD@mandrakesoft.com>
Date: Thu, 21 Feb 2002 05:15:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Thanks, but i think i wasted my time on this one, there is a driver for
> most of the SC1200 bits (including watchdog) at http://www.nano-system.com/scx200

I just looked at their watchdog driver -- yours might be better...  They
don't use semaphores in _open, they don't use request_region, etc.

Of course, OTOH their include list is smaller and they don't use
MOD_{INC,DEC}_USE_COUNT ;-)

	Jeff

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
