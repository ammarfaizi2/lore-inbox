Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBMn>; Fri, 5 Jan 2001 20:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130690AbRAFBMd>; Fri, 5 Jan 2001 20:12:33 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:20230 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S129324AbRAFBM1>; Fri, 5 Jan 2001 20:12:27 -0500
To: Chris Kloiber <ckloiber@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu>
        <3A55F6DB.24041B4C@rochester.rr.com>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 06 Jan 2001 01:12:23 +0000
Message-ID: <y7rofxlwkjs.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Kloiber <ckloiber@rochester.rr.com> writes:
> last 2 lines in dmesg output:
> mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000
> mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000

Are you running XFree86-4.0.x?

> cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0xd8000000 (3456MB), size=  16MB: write-combining, count=1
> reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
>  
> 
> My video card is Voodoo3/3000/AGP and my motherboard is an MSI-6330
> (Athlon Tbird 800)
> I am experiencing text console video corruption. In tdfxfb mode or
> regular vesafb it looks like a horizontal line of color pixels that
> grows, in 'regular' text mode I get flashing characters or the font
> degrades into unreadable mess. X is fine.

What does "lspci -v" give?


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
