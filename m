Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRAZTw3>; Fri, 26 Jan 2001 14:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAZTwJ>; Fri, 26 Jan 2001 14:52:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27652 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129706AbRAZTwG>;
	Fri, 26 Jan 2001 14:52:06 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101261948.f0QJm6q09263@flint.arm.linux.org.uk>
Subject: Re: 2.4.1-pre8 losing pages
To: pdh@colonel-panic.com (Peter Horton)
Date: Fri, 26 Jan 2001 19:48:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010126194605.A923@colonel-panic.com> from "Peter Horton" at Jan 26, 2001 07:46:05 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton writes:
> The corruption is dependent on having a swapped on swap partition. If I
> "swapoff" the corruption goes away, but it comes back when I "swapon"
> again. I feel this a kernel bug, but as I'm the only person out here who's
> seeing it I'm at a loss ...

What compiler are you using?

The reason I ask is that on an ARM box running plain 2.4.0 with swap
enabled I get rather a lot of SEGVs.  Turn swap off, and I don't see
any.

It sounds like it may be related.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
