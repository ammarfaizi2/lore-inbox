Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAHUy0>; Mon, 8 Jan 2001 15:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHUyP>; Mon, 8 Jan 2001 15:54:15 -0500
Received: from lairdtest1.internap.com ([206.253.215.67]:17931 "EHLO
	lairdtest1.internap.com") by vger.kernel.org with ESMTP
	id <S129226AbRAHUyL>; Mon, 8 Jan 2001 15:54:11 -0500
Date: Mon, 8 Jan 2001 12:54:04 -0800 (PST)
From: Scott Laird <laird@internap.com>
To: Chris Meadors <clubneon@hereintown.net>
cc: Igmar Palsenberg <maillist@chello.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.
In-Reply-To: <Pine.LNX.4.31.0101081043160.17858-100000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.4.21.0101081253110.13252-100000@lairdtest1.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is syslog running correctly?  When syslog screws up, it very frequently
results in this sort of problem.


Scott

On Mon, 8 Jan 2001, Chris Meadors wrote:

> On Mon, 8 Jan 2001, Igmar Palsenberg wrote:
> 
> > check /etc/pam.d/login
> 
> No pam.
> 
> > Could be kerberos that is biting you, althrough that doesn't explain the
> > portmap story.
> 
> So no kerberos.
> 
> I just rebuilt the shadow suite (where my login comes from) to be on the
> safe side.  But the problem is still there.
> 
> ldd login shows:
>         libshadow.so.0 => /lib/libshadow.so.0 (0x4001a000)
>         libcrypt.so.1 => /lib/libcrypt.so.1 (0x40033000)
>         libc.so.6 => /lib/libc.so.6 (0x40060000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
> 
> I'm running glibc-2.2, but this problem also existed in 2.1.x (which I had
> installed when I went to the 2.3 kernels that exposed this problem).
> 
> -Chris
> -- 
> Two penguins were walking on an iceberg.  The first penguin said to the
> second, "you look like you are wearing a tuxedo."  The second penguin
> said, "I might be..."                         --David Lynch, Twin Peaks
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
