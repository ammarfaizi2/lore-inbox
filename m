Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280684AbRKBNRw>; Fri, 2 Nov 2001 08:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280685AbRKBNRl>; Fri, 2 Nov 2001 08:17:41 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:50898 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S280684AbRKBNRY>;
	Fri, 2 Nov 2001 08:17:24 -0500
Date: Fri, 2 Nov 2001 15:16:09 +0200 (EET)
From: lkml user <lk@ts.ray.fi>
To: Roman Zippel <zippel@linux-m68k.org>
cc: <linux-kernel@vger.kernel.org>, <engler@stanford.edu>
Subject: Re: null pointer questions
In-Reply-To: <Pine.LNX.4.33.0111021346460.11407-100000@serv>
Message-ID: <Pine.LNX.4.33.0111021515570.9858-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Roman Zippel wrote:

> Hi,
> 
> On Thu, 1 Nov 2001, Ken Ashcraft wrote:
> 
> > 1. If I pass size 0 to kmalloc, what does it return?
> 
> AFAIK size is always rounded up, so you get the smallest possible
> allocation unit.
> 
> > 2. What happens if I pass a null pointer as the destination parameter
> > to copy_from_user?  Does copy_from_user handle it safely or will the
> > kernel seg fault?
> 
> The kernel won't crash, but it might fail (depending on whether 0 is a
> valid user space address or not).
> 
> bye, Roman
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

