Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132783AbRBETF6>; Mon, 5 Feb 2001 14:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133066AbRBETFs>; Mon, 5 Feb 2001 14:05:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132783AbRBETFi>; Mon, 5 Feb 2001 14:05:38 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: sct@redhat.com (Stephen C. Tweedie)
Date: Mon, 5 Feb 2001 19:04:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sct@redhat.com (Stephen C. Tweedie),
        manfred@colorfullife.com (Manfred Spraul),
        torvalds@transmeta.com (Linus Torvalds),
        hch@caldera.de (Christoph Hellwig), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010205184911.A2116@redhat.com> from "Stephen C. Tweedie" at Feb 05, 2001 06:49:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PqwS-0003xj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kiobufs have never, ever required the IO to be aligned on any
> particular boundary.  They simply make the assumption that the
> underlying buffered object can be described in terms of pages with
> some arbitrary (non-aligned) start/offset.  Every video framebuffer

start/length per page ?

> I've ever seen satisfies that, so you can easily map an arbitrary
> contiguous region of the framebuffer with a kiobuf already.

Video is non contiguous ranges. In fact if you are blitting to a card with
tiled memory it gets very interesting in its video lists

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
