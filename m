Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132507AbRDDWel>; Wed, 4 Apr 2001 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRDDWea>; Wed, 4 Apr 2001 18:34:30 -0400
Received: from rachael.franken.de ([193.175.24.38]:30737 "EHLO
	rachael.franken.de") by vger.kernel.org with ESMTP
	id <S132507AbRDDWeT>; Wed, 4 Apr 2001 18:34:19 -0400
Date: Wed, 4 Apr 2001 23:51:24 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Wade Hampton <whampton@staffnet.com>,
        Carsten Langgaard <carstenl@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
Message-ID: <20010404235124.B3102@alpha.franken.de>
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com> <3ACB3CA5.D978EF41@staffnet.com> <3ACB8098.DFEC12D7@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3ACB8098.DFEC12D7@vc.cvut.cz>; from vandrove@vc.cvut.cz on Wed, Apr 04, 2001 at 01:14:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 01:14:16PM -0700, Petr Vandrovec wrote:
> VMware is working on implementation PCnet 32bit mode in emulation (there
> is no such thing now because of no OS except FreeBSD needs it). But
> my question is - is there some real benefit in running chip in
> 32bit mode?

probably not.

> so is 32bit mode needed for bigendian ports, or what's reasoning
> behind it?

I've added 32bit mode for some IBM PowerPC machines. The firmware
on this machines setup the chip to DWIO and I haven't found a way
to switch it back to WIO.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
