Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQKFT5L>; Mon, 6 Nov 2000 14:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbQKFT5B>; Mon, 6 Nov 2000 14:57:01 -0500
Received: from u-245.karlsruhe.ipdial.viaginterkom.de ([62.180.10.245]:57095
	"EHLO u-245.karlsruhe.ipdial.viaginterkom.de") by vger.kernel.org
	with ESMTP id <S129392AbQKFT4t>; Mon, 6 Nov 2000 14:56:49 -0500
Date: Mon, 6 Nov 2000 18:14:06 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Aaron Sethman <androsyn@ratbox.org>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001106181406.A22305@bacchus.dhis.org>
In-Reply-To: <20001102201836.A14409@gruyere.muc.suse.de> <Pine.LNX.4.21.0011040031450.11261-100000@squeaker.ratbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011040031450.11261-100000@squeaker.ratbox.org>; from androsyn@ratbox.org on Sat, Nov 04, 2000 at 12:34:23AM -0500
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 12:34:23AM -0500, Aaron Sethman wrote:

> > SGI's pro64 is free software and AFAIK is able to compile a kernel on IA64.
> > It is also not clear if gcc will ever produce good code on IA64.
> 
> Well if its compiling the kernel just fine without alterations to the
> code, then fine. If not, if the SGI compiler is GPL'd pillage its sources
> and get that code working in gcc. Otherwise, trying to get linux to work
> with other C compilers doesn't seem worth the effort. 

Pro64 is gcc derived and intended to be 100% source compatible with gcc.
Past experience with new optimizations in gcc is they they frequently
triggered bugs in the kernel source which simply was relying on the code
generation working in a certain way.  Given that and assuming that the
degree of Pro64's optimizations is somewhat revolutionary when compared
to gcc I would expect that we'll hit a number of kernel bugs.  I'm not
even thinking about actual Pro64 bugs itself.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
