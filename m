Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRBETS2>; Mon, 5 Feb 2001 14:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbRBETST>; Mon, 5 Feb 2001 14:18:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13830 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130332AbRBETSE>; Mon, 5 Feb 2001 14:18:04 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 5 Feb 2001 19:16:55 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), alan@lxorguk.ukuu.org.uk (Alan Cox),
        manfred@colorfullife.com (Manfred Spraul),
        hch@caldera.de (Christoph Hellwig), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.10.10102051101100.31165-100000@penguin.transmeta.com> from "Linus Torvalds" at Feb 05, 2001 11:09:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Pr8G-0003zV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stop this idiocy, Stephen. You're _this_ close to be the first person I
> ever blacklist from my mailbox. 

I think I've just figured out what the miscommunication is around here

kiovecs can describe arbitary scatter gather

its just that they can also cleanly describe the common case of contiguous
pages in one entry.

After all a subpage block is simply a contiguous set of 1 page.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
