Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbSLEVM0>; Thu, 5 Dec 2002 16:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbSLEVEN>; Thu, 5 Dec 2002 16:04:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18180 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267429AbSLEU5W>;
	Thu, 5 Dec 2002 15:57:22 -0500
Date: Wed, 4 Dec 2002 12:11:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: XI <xizard@enib.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
Message-ID: <20021204111153.GA309@elf.ucw.cz>
References: <3DEA322B.40204@enib.fr> <1038765233.30392.0.camel@irongate.swansea.linux.org.uk> <3DEAA660.60004@enib.fr> <1038845393.1020.26.camel@irongate.swansea.linux.org.uk> <3DEBAAE6.6000106@enib.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEBAAE6.6000106@enib.fr>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I was thinking about a problem with my chipset (AMD760MPX, motherboard 
> >>tyan tiger MPX); because I have done some tests on a PC with a matrox 
> >>G200 PCI and a sound blaster live, with a chipset via KT333 and the 
> >>problem doesn't seems to occur. Is it possible?
> >
> >
> >Could be - the newer kernel supports IDE DMA, and in my experience the
> >AMD76x has serious fairness problems (I gave up using it for video
> >capture)
> >
> 
> This doesn't reassure me :-) but I didn't get the choice for an SMP 
> machine with some athlon processors.
> 
> Note that I am also able to use IDE DMA with the kernel 2.4.8 (ie hdparm 
> -d 1 /dev/hd. works)
> 
> 
> So now, do you want me to try other kernel version in order to find in 
> what version the problem appeared?

Try turning off power managment... CONFIG_ACPI and CONFIG_APM off. If
it helps, your power supply is just not good enough.
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
