Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTBJG4f>; Mon, 10 Feb 2003 01:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTBJG4f>; Mon, 10 Feb 2003 01:56:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:57738 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263333AbTBJG4e>; Mon, 10 Feb 2003 01:56:34 -0500
Date: Mon, 10 Feb 2003 10:06:18 +0300
From: Oleg Drokin <green@namesys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4 comparison bugs (More of those)
Message-ID: <20030210100618.A5722@namesys.com>
References: <20030208171838.GA2230@linuxhacker.ru> <1044752320.18908.18.camel@irongate.swansea.linux.org.uk> <20030209175349.GA20635@linuxhacker.ru> <1044828089.30767.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044828089.30767.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Feb 09, 2003 at 10:01:30PM +0000, Alan Cox wrote:
> > This time I changed the type of variable to signed type whenever
> > I felt it was appropriate.
> > When I was not sure (or unsigned type was in some commonly used
> > structure), I still used a cast just to highlight a problem, so that someone
> > more knowledgeable created better fix.
> > See the patch.
> > Mostly we do incorrect stuff on errors. Sigh, nobody likes errors ;)
> Hiding them is even worse than having them there visible and unfixed.
> Changing the sign on stuff holding physical addresses is actually
> introducing real bugs

I assume you are speaking of slram stuff here.
I thought that slram was not designed to work with parts of RAM past 2G border.
(as far as I remember, slram was used on old x86 HW to convert uncached RAM
beyond 64M (256M for some systems?) into kind of a ramdisk.)

Bye,
    Oleg
