Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbSLSWGN>; Thu, 19 Dec 2002 17:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLSWGN>; Thu, 19 Dec 2002 17:06:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4612 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267135AbSLSWGM>;
	Thu, 19 Dec 2002 17:06:12 -0500
Date: Thu, 19 Dec 2002 00:55:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218235546.GD705@elf.ucw.cz>
References: <Pine.LNX.4.10.10212170144030.31876-100000@master.linux-ide.org> <1040137976.20018.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040137976.20018.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Are you serious about moving of the banging we currently do on 0x80?
> > If so, I have a P4 development board with leds to monitor all the lower io
> > ports and can decode for you.
> 
> Different thing - int 0x80 syscall not i/o port 80. I've done I/O port
> 80 (its very easy), but requires we set up some udelay constants with an
> initial safety value right at boot (which we should do - we udelay
> before it is initialised)

Actually that would be nice -- I have leds on 0x80 too ;-).
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
