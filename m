Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRALK62>; Fri, 12 Jan 2001 05:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRALK6T>; Fri, 12 Jan 2001 05:58:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40709 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129401AbRALK6N>;
	Fri, 12 Jan 2001 05:58:13 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101111036.KAA07188@brick.arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
To: ak@suse.de (Andi Kleen)
Date: Thu, 11 Jan 2001 10:36:45 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), mantel@suse.de (Hubert Mantel),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010111113353.B20569@gruyere.muc.suse.de> from "Andi Kleen" at Jan 11, 2001 11:33:53 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> The change is rather useless anyways, because even in NFSv3 file handles
> cannot be >64bytes. Would even fit in a char, doesn't need a short nor an
> int. 

Indeed, but whether it be a char or a short, it'll still break on ARM.  My
original set of 3 solutions still stand therefore.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
