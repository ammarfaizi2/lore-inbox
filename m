Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265055AbSJRHWR>; Fri, 18 Oct 2002 03:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265056AbSJRHWQ>; Fri, 18 Oct 2002 03:22:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25331 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265055AbSJRHWN>;
	Fri, 18 Oct 2002 03:22:13 -0400
Date: Fri, 18 Oct 2002 03:28:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Crispin Cowan <crispin@wirex.com>
cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <3DAFB260.5000206@wirex.com>
Message-ID: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Oct 2002, Crispin Cowan wrote:

>     * server users can choose a highly secure model
>     * workstation users can choose something desktop oriented
>     * embedded people can choose nothing at all, or the specific
>       narrow-cast model that they need
> 
> On the other hand: what is the big cost here? One system call. Isn't 
> that actually *lower* overhead than the (say) half dozen 
> security-oriented syscalls we might convince you to accept if we drop 
> the sys_security syscall as you suggest? Why the fierce desire to remove 
> something so cheap?

Because ugliness has its price.  As for "highly secure"...  Could we please
see some proof?  Clearly stated properties with code audit to verify them
would be nice.

I'm yet to see a single shred of evidence that so-called security improvements
actually do improve security (as opposed to feeling of security - quite
a different animal).  And in this case burden of proof is clearly on your
side.

What I _do_ see is a lucrative market for peddlers of feel-good "solutions"
that do not make anything secure but have miles-long feature lists that
can be used to impress PHBs.  Now, I have no particular problems with
people who help suckers part with their money, but I don't see any reason
to support them.

3 or 4 patches that might be interesting would be better off without LSM.
The rest...  care to give a hard evidence that it is worth any support?

