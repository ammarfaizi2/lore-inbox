Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262458AbREUKfN>; Mon, 21 May 2001 06:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbREUKfD>; Mon, 21 May 2001 06:35:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57728 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262461AbREUKey>;
	Mon, 21 May 2001 06:34:54 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.61258.251051.960811@pizda.ninka.net>
Date: Mon, 21 May 2001 03:34:50 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521122753.A2507@gruyere.muc.suse.de>
In-Reply-To: <20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521112357.A1718@gruyere.muc.suse.de>
	<15112.57377.723591.710628@pizda.ninka.net>
	<20010521114216.A1968@gruyere.muc.suse.de>
	<15112.59192.613218.796909@pizda.ninka.net>
	<20010521122753.A2507@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > [BTW, the 2.4.4 netstack does not seem to make any attempt to handle the
 > pagecache > 4GB case on IA32 for sendfile, as the pci_* functions are dummies 
 > here.  It probably needs bounce buffers there for this case]

egrep illegal_highdma net/core/dev.c

Later,
David S. Miller
davem@redhat.com
