Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbREUMWF>; Mon, 21 May 2001 08:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261219AbREUMVz>; Mon, 21 May 2001 08:21:55 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:29714 "HELO
	zmamail04.zma.compaq.com") by vger.kernel.org with SMTP
	id <S261254AbREUMVm>; Mon, 21 May 2001 08:21:42 -0400
Message-ID: <3B090733.129C37EB@zk3.dec.com>
Date: Mon, 21 May 2001 08:16:51 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <15112.60362.447922.780857@pizda.ninka.net> <20010521130034.L30738@athlon.random> <15112.63036.13578.8126@pizda.ninka.net> <20010521132750.N30738@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Mon, May 21, 2001 at 04:04:28AM -0700, David S. Miller wrote:
> > How many physical PCI slots on a Tsunami system?  (I know the
>
> on tsunamis probably not many, but on a Typhoon (the one in the es40
> that is the 4-way extension) I don't know, but certainly the box is
> large.
>

ES40 has either 8 or 10 PCI slots across 2 PCI buses.  And then there's
Wildfire - 14 slots per PCI drawer (4 PCI buses) * 2 drawers/QBB * 8 QBBs =
224 PCI slots & 64 PCI buses.  BTW, Titan (aka ES45) has 10 slots as well,
but with 3 buses instead.

 - Pete

