Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbREUGyC>; Mon, 21 May 2001 02:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261688AbREUGxw>; Mon, 21 May 2001 02:53:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261687AbREUGxt>;
	Mon, 21 May 2001 02:53:49 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.47990.828744.956717@pizda.ninka.net>
Date: Sun, 20 May 2001 23:53:42 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521033706.F30738@athlon.random>
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<20010520181803.I18119@athlon.random>
	<3B07EEFE.43DDBA5C@uow.edu.au>
	<20010520184411.K18119@athlon.random>
	<3B07F6B8.4EAB0142@uow.edu.au>
	<20010520191206.A30738@athlon.random>
	<15112.27206.4123.40450@pizda.ninka.net>
	<20010521033706.F30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > Assume I have a dozen of PCI cards that does DMA using SG tables that
 > can map up to some houndred mbytes of ram each, so I can just program
 > the cards to start the dma on those houndred mbyte of ram, most of the
 > time the I/O is not simulaneous, but very rarely it happens to be
 > simultaneous and in turn it tries to pci_map_sg more than 4G of physical
 > ram.

What are these "devices", and what drivers "just program the cards to
start the dma on those hundred mbyte of ram"?

Are we designing Linux for hypothetical systems with hypothetical
devices and drivers, or for the real world?

Later,
David S. Miller
davem@redhat.com
