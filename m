Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbRBER23>; Mon, 5 Feb 2001 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135468AbRBER2K>; Mon, 5 Feb 2001 12:28:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13061 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129539AbRBER16>; Mon, 5 Feb 2001 12:27:58 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 5 Feb 2001 17:27:12 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul),
        sct@redhat.com (Stephen C. Tweedie),
        hch@caldera.de (Christoph Hellwig), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.10.10102050851030.30798-100000@penguin.transmeta.com> from "Linus Torvalds" at Feb 05, 2001 08:56:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PpQ3-0003l2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In fact, regular IDE DMA allows arbitrary scatter-gather at least in
> theory. Linux has never used it, so I don't know how well it works in

Purely in theory, as Jeff found out. 

> But despite a lot of likely practical reasons why it won't work for
> arbitrary sg lists on plain IDE DMA, there is no _theoretical_ reason it
> wouldn't. And there are bound to be better controllers that could handle
> it.

I2O controllers are required too handle it (most dont) and some of the high
end scsi/fc controllers even get it right


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
