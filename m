Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbREVUx1>; Tue, 22 May 2001 16:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbREVUxR>; Tue, 22 May 2001 16:53:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2412 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262813AbREVUxL>; Tue, 22 May 2001 16:53:11 -0400
Date: Tue, 22 May 2001 22:52:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: alpha iommu fixes
Message-ID: <20010522225231.K15155@athlon.random>
In-Reply-To: <15112.62766.368436.236478@pizda.ninka.net> <20010521131959.M30738@athlon.random> <20010521155151.A10403@jurassic.park.msu.ru> <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random> <20010522162916.B15155@athlon.random> <20010522184409.A791@jurassic.park.msu.ru> <20010522170016.D15155@athlon.random> <20010522132815.A4573@twiddle.net> <3B0ACEB1.F3806F00@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0ACEB1.F3806F00@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 22, 2001 at 04:40:17PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 04:40:17PM -0400, Jeff Garzik wrote:
> ISA cards can do sg?

The fact it's sg or single physically consecutive since the first place
doesn't matter.  The only point here is that from whatever physically
aligned piece of ram right now you will get a misaligned virtual pci
address.

Andrea
