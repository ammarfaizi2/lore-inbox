Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132976AbRBEPTx>; Mon, 5 Feb 2001 10:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132990AbRBEPTm>; Mon, 5 Feb 2001 10:19:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21252 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132976AbRBEPTk>; Mon, 5 Feb 2001 10:19:40 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: sct@redhat.com (Stephen C. Tweedie)
Date: Mon, 5 Feb 2001 15:19:09 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul),
        sct@redhat.com (Stephen C. Tweedie),
        torvalds@transmeta.com (Linus Torvalds),
        hch@caldera.de (Christoph Hellwig), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010205150354.E1167@redhat.com> from "Stephen C. Tweedie" at Feb 05, 2001 03:03:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PnQ8-0003WC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it's the sort of thing that you would hope should work, but in
> practice it's not reliable.

So the less smart devices need to call something like

	kiovec_align(kiovec, 512);

and have it do the bounce buffers ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
