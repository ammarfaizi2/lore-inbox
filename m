Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132430AbRAFTWx>; Sat, 6 Jan 2001 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbRAFTWm>; Sat, 6 Jan 2001 14:22:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48651 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129538AbRAFTWb>; Sat, 6 Jan 2001 14:22:31 -0500
Subject: Re: [PATCH] VESA framebuffer w/MTRR locks 2.4.0 on init
To: bmayland@leoninedev.com (Bryan Mayland)
Date: Sat, 6 Jan 2001 19:23:40 +0000 (GMT)
Cc: dpw@doc.ic.ac.uk (David Wragg), alan@lxorguk.ukuu.org.uk (Alan Cox),
        kraxel@goldbach.in-berlin.de, linux-kernel@vger.kernel.org
In-Reply-To: <3A575104.F06D87BC@leoninedev.com> from "Bryan Mayland" at Jan 06, 2001 12:08:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EywJ-0001PR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> an MTRR more than once.  The restrictions on MTRR size and alignment are too
> numerous to attempt a logical resizing in a small amount of code-- especially
> since the retrictions are different depending on the processor.  Might I suggest
> that the looping code be taken out entirely, perhaps outputting success or

Power of two shrinkage works for most cases


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
