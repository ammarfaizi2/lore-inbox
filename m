Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129549AbQKIQkg>; Thu, 9 Nov 2000 11:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbQKIQkZ>; Thu, 9 Nov 2000 11:40:25 -0500
Received: from [62.172.234.2] ([62.172.234.2]:41884 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129815AbQKIQkN>;
	Thu, 9 Nov 2000 11:40:13 -0500
Date: Thu, 9 Nov 2000 16:41:41 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: why do we need pg1?
In-Reply-To: <Pine.LNX.4.21.0011091604100.1327-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011091641010.1549-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Tigran Aivazian wrote:

> Hi,
> 
> The code which sets up the page table at pg0 (in head.S) goes all the way
> until it hits empty_zero_page so I don't understand why we need the label
> pg1 in between, since it is never referred to by any other code?
> 
> Also, is the comment in asm/pgtable.h
> 
> /* page table for 0-4MB for everybody */
> extern unsigned long pg0[1024];
> 
> true or false? Isn't it for 0-8M as head.S claims?

after a minute of thought, the answer to the second question is now
obvious, but the answer to the first one still is _not_.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
