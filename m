Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbREULEx>; Mon, 21 May 2001 07:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262475AbREULEn>; Mon, 21 May 2001 07:04:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15233 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262474AbREULEb>;
	Mon, 21 May 2001 07:04:31 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.63036.13578.8126@pizda.ninka.net>
Date: Mon, 21 May 2001 04:04:28 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521130034.L30738@athlon.random>
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521115631.I30738@athlon.random>
	<15112.59880.127047.315855@pizda.ninka.net>
	<15112.60362.447922.780857@pizda.ninka.net>
	<20010521130034.L30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > On Mon, May 21, 2001 at 03:19:54AM -0700, David S. Miller wrote:
 > > max bytes per bttv: max_gbuffers * max_gbufsize
 > > 		    64           * 0x208000      == 133.12MB
 > > 
 > > 133.12MB * 8 PCI slots == ~1.06 GB
 > > 
 > > Which is still only half of the total IOMMU space available per
 > > controller.
 > 
 > and it is the double of the iommu space that I am going to reserve for
 > pci dynamic mappings on the tsunami (right now it is 128Mbyte... and I'll
 > change to 512mbyte)

How many physical PCI slots on a Tsunami system?  (I know the
answer, this question is rhetorical :-)

See?  This is why I think all these examples are silly, and we
need to be realistic about this whole situation.

Later,
David S. Miller
davem@redhat.com
