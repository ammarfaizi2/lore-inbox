Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272361AbTGaAWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTGaAWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:22:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32496 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272361AbTGaAWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:22:34 -0400
Date: Thu, 31 Jul 2003 02:22:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731002230.GE22991@fs.tum.de>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730203318.GH1873@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 10:33:18PM +0200, Jan-Benedict Glaw wrote:
>...
> That sounds a tad inelegant to me. Really, I'd prefer to see libstdc++
> be compiled for i386 ...
> 
> ...and IFF those new opcodes bring _that_ much performance, then we
> should think about another Debian distribution for i686-linux. Up to
> now, I was really proud of having _one_ distribution that's basically
> capable of running on all and any machines I own...

The 486 emlation patch for 386 is the way to still allow 386's to run 
Debian.

To compile libstdc++ for 486 wasn't a performance question - a
libstdc++.so.5 compiled for 386 would have meant that C++ binaries
compiled on Debian wouldn't run on other Linux distributions and vice
versa [1] (it's a bug in libstdc++ that will AFAIR be fixed in gcc 3.4).

> MfG, JBG

cu
Adrian

[1] http://lists.debian.org/debian-devel/2003/debian-devel-200304/msg01895.html

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

