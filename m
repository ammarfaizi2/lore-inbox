Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSH1IbV>; Wed, 28 Aug 2002 04:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSH1IbV>; Wed, 28 Aug 2002 04:31:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47376 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318783AbSH1IbV>; Wed, 28 Aug 2002 04:31:21 -0400
Date: Wed, 28 Aug 2002 09:35:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Message-ID: <20020828093539.A22004@flint.arm.linux.org.uk>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <20020827202250.GA24265@debian> <6e0.3d6be706.b5d05@gzp1.gzp.hu> <20020828061827.GB27967@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020828061827.GB27967@lug-owl.de>; from jbglaw@lug-owl.de on Wed, Aug 28, 2002 at 08:18:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 08:18:27AM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2002-08-27 20:54:30 -0000, Gabor Z. Papp <gzp@myhost.mynet>
> wrote in message <6e0.3d6be706.b5d05@gzp1.gzp.hu>:
> >   gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5.32-gzp3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux-2.5.32-gzp3/include/linux/modversions.h   -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o 8250.o 8250.c
> > In file included from 8250.c:34:
> > /usr/src/linux-2.5.32-gzp3/include/linux/serialP.h:50: field `icount' has incomplete type
> 
> Header file problem. In serialP.h, right at the beginning, there's a
> version check, which unfortunately is in wrong direction. No sources
> available, no patch...

It generally helps to search the list archives:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102833316026209&w=2

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

