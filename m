Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSLMNkd>; Fri, 13 Dec 2002 08:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSLMNjV>; Fri, 13 Dec 2002 08:39:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45071 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262901AbSLMNjA>; Fri, 13 Dec 2002 08:39:00 -0500
Date: Fri, 13 Dec 2002 14:46:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51: new warning from lilo
Message-ID: <20021213134648.GA31042@atrey.karlin.mff.cuni.cz>
References: <20021212193451.GA458@elf.ucw.cz> <1039789418.25121.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039789418.25121.25.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Lilo now presents me with new warning:
> > 
> > Warning: Kernel & BIOS return differing head/sector geometries for
> > device 0x80
> >     Kernel: 8944 cylidners, 15 heads, 63 sectors
> >       BIOS: 525 cylinders, 255 heads, 63 sectors
> > 
> > lilo did not warn under 2.5.50. Now... Will it boot?
> 
> Someone took various bits of geometry mapping out of the kernel. It will
> now give different values. As to whether lilo will still boot I don't
> know. I'd be suprised if it was a problem. 

It still boots.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
