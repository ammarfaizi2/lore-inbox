Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUHOXWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUHOXWM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUHOXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:22:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27075 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267235AbUHOXWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:22:05 -0400
Date: Mon, 16 Aug 2004 01:22:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040815232201.GT1387@fs.tum.de>
References: <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org> <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home> <20040814204711.GD1387@fs.tum.de> <Pine.LNX.4.61.0408151928490.12687@scrub.home> <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be> <Pine.LNX.4.61.0408160050440.12687@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408160050440.12687@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 01:01:35AM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Sun, 15 Aug 2004, Geert Uytterhoeven wrote:
> 
> > > What about normal numbers? I don't think requiring quotes everywhere for
> > > this is a good idea.
> > 
> > And numbers (both decimal and hex) can easily be distinguished from y, n, and m
> > anyway.
> 
> I did consider this at some point, but I didn't want to add further 
> special cases. Every symbol has a tristate and a string value and so you 
> can compare pretty much everything with everything else. Splitting the 
> string value further into other types isn't worth the trouble. The problem 
> at hand is easy enough to solve by adding a type declaration.

if things stay as they are, we _really_ need warnings for !=n and 
rewrite the correct ones to (FOO=y || FOO=m).

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

