Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135579AbRAUMHR>; Sun, 21 Jan 2001 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbRAUMG7>; Sun, 21 Jan 2001 07:06:59 -0500
Received: from colorfullife.com ([216.156.138.34]:24334 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S135526AbRAULt0>;
	Sun, 21 Jan 2001 06:49:26 -0500
Message-ID: <3A6ACCBC.C246C3F8@colorfullife.com>
Date: Sun, 21 Jan 2001 12:49:16 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
In-Reply-To: <200101211051.f0LApFv02203@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Manfred Spraul writes:
> > Not yet, but that would be a 2 line patch (currently it's hardcoded to
> > BYTES_PER_WORD align or L1_CACHE_BYTES, depending on the HWCACHE_ALIGN
> > flag).
> 
> I don't think there's a problem then.  However, if slab can be told "I want
> 1024 bytes aligned to 1024 bytes" then I can get rid of
> arch/arm/mm/small_page.c (separate problem to the one we're discussing
> though) ;)
> 

That's easy, I'll include it in my next slab update.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
