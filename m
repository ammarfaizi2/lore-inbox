Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129600AbQKKLf4>; Sat, 11 Nov 2000 06:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbQKKLfq>; Sat, 11 Nov 2000 06:35:46 -0500
Received: from [62.172.234.2] ([62.172.234.2]:58034 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129600AbQKKLfd>;
	Sat, 11 Nov 2000 06:35:33 -0500
Date: Sat, 11 Nov 2000 11:36:00 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Max Inux <maxinux@bigfoot.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <3A0CB6FD.D4CCE09F@transmeta.com>
Message-ID: <Pine.LNX.4.21.0011111133050.1029-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, H. Peter Anvin wrote:
> > 
> > On x86 machines there is a size limitation on booting.  Though I thought
> > it was 1024K as the max, 900K should be fine.
> > 
> 
> No, there isn't.  There used to be, but it has been fixed.
> 

Are you sure? I thought the fix was to build 2 page tables for 0-8M
instead of 1 page table for 0-4M. So, we still cannot boot a bzImage more
than 2.5M which roughly corresponds to 8M. Is this incorrect? Are you
saying I should be able to boot a bzImage corresponding to an ELF object
vmlinux of 4G or more?

I tried it and it failed (a few weeks ago) so at least reasonably recently
what you are saying was not true. I will now check if it suddenly became
true now.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
