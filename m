Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280861AbRKBWnd>; Fri, 2 Nov 2001 17:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280863AbRKBWnP>; Fri, 2 Nov 2001 17:43:15 -0500
Received: from saga18.Stanford.EDU ([171.64.15.148]:35054 "EHLO
	saga18.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S280860AbRKBWnA>; Fri, 2 Nov 2001 17:43:00 -0500
Date: Fri, 2 Nov 2001 14:42:36 -0800 (PST)
From: Ken Ashcraft <kash@Stanford.EDU>
To: Roman Zippel <zippel@linux-m68k.org>
cc: <linux-kernel@vger.kernel.org>, <engler@Stanford.EDU>
Subject: Re: null pointer questions
In-Reply-To: <Pine.LNX.4.33.0111021346460.11407-100000@serv>
Message-ID: <Pine.GSO.4.33.0111021433590.6907-100000@saga18.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2. What happens if I pass a null pointer as the destination parameter
> > to copy_from_user?  Does copy_from_user handle it safely or will the
> > kernel seg fault?
>
> The kernel won't crash, but it might fail (depending on whether 0 is a
> valid user space address or not).

Why does it matter if 0 is a valid user space or not?  If I make the call

copy_from_user(0, user_ptr, 4);

the null pointer is the kernel address, not the user address.  Can you
clarify please?

Thanks
Ken

