Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAVWUi>; Mon, 22 Jan 2001 17:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130536AbRAVWUZ>; Mon, 22 Jan 2001 17:20:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129742AbRAVWUR>;
	Mon, 22 Jan 2001 17:20:17 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101222202.f0MM24s01811@flint.arm.linux.org.uk>
Subject: Re: Running "make install" runs lilo on my Athlon but not my Pentium II.
To: miles@megapathdsl.net
Date: Mon, 22 Jan 2001 22:02:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A6BED1D.86D5B597@megapathdsl.net> from "Miles Lane" at Jan 22, 2001 12:19:41 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane writes:
> When I run "make install" on my Pentium II machine, lilo gets
> run after vmlinuz is built.  When I do the same thing on my Athlon,
> vmlinuz gets built, but lilo does get run.

Have you checked for the existance of a /sbin/installkernel file on either
machine?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
