Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRALK63>; Fri, 12 Jan 2001 05:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRALK6T>; Fri, 12 Jan 2001 05:58:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129383AbRALK6L>;
	Fri, 12 Jan 2001 05:58:11 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101111327.NAA07244@brick.arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
To: manfred@colorfullife.com (Manfred)
Date: Thu, 11 Jan 2001 13:27:34 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), manfred@colorfullife.com (Manfred),
        rmk@arm.linux.org.uk (Russell King), andrea@suse.de (Andrea Arcangeli),
        mantel@suse.de (Hubert Mantel),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <979216159.3a5da71fdc35b@colorfullife.com> from "Manfred" at Jan 11, 2001 07:29:19 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred writes:
> 2.2.18 struct nfs_fh is a new structure for nfsV3, it doesn't exist in 2.2.17.
> That structure is unusable on ARM.

Correct.

> Russel want's to change the new "struct nfs_fh" (from 2.2.18), and that
> change is included in 2.2.19pre7. But that change breaks i386 nfs mount.

Unfortunately.

> Could someone with an Alpha/Sparc/ARM compiler compile a test program with
> "struct nfs_fh" from 2.2.18 and print the offset of nfs_fh.data?

2
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
