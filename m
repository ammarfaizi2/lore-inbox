Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSHGNKt>; Wed, 7 Aug 2002 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHGNJT>; Wed, 7 Aug 2002 09:09:19 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10003 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S317351AbSHGNIM>;
	Wed, 7 Aug 2002 09:08:12 -0400
Date: Wed, 7 Aug 2002 15:08:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
Message-ID: <20020807130825.GA943@alpha.home.local>
References: <Pine.LNX.4.44.0208071332110.3394-100000@pc40.e18.physik.tu-muenchen.de> <1028726077.18478.284.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028726077.18478.284.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 02:14:37PM +0100, Alan Cox wrote:
> I've never been able to get a broadcom chipset ethernet card stable on a
> dual athlon with AMD 76x chipset. I have no idea what the problem is
> although it certainly appears to be PCI versus main memory ordering
> funnies.

have you tried it in a 5V slot ? My DL2K nearly doesn't work at all in
3V slots: it sends hundreds of packets, and the driver needs to be unloaded
then reloaded. In a 5V slot, at least, it hangs really later :-/

At first, I thought it came from a problem with the 64bit slots, but I had
problems with this card only on 3V slots on other machines. Although it's
not a broadcom chipset, the problem may be similar.

Cheers,
Willy

