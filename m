Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUE3EA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUE3EA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 00:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUE3EA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 00:00:29 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:30915 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261654AbUE3EA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 00:00:27 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
Date: Sat, 29 May 2004 20:59:57 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: bk-3.2.0 released
In-Reply-To: <20040529154714.GC20605@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0405292054570.3238@dlang.diginsite.com>
References: <20040518233238.GC28206@work.bitmover.com> <20040529095419.GB1269@ucw.cz>
 <20040529130436.GA20605@work.bitmover.com> <20040529131510.GB13999@selene>
 <20040529154714.GC20605@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually I think that Suse / UnitedLinux were first (for what little
difference it makes :-)

what libraries do you need? we could have those of us who have x86_64
systems could report the versions we have on our distros.

David Lang

P.S. you may be surprised by the perfomance improvements. I recently
benchmarked apache as almost doubling it's performance when going from
32bit code to 64 bit code on the same hardware/distro/config file and
things I have read on the internet show similar improvements for database
software

On Sat, 29 May 2004, Larry McVoy wrote:

> Date: Sat, 29 May 2004 08:47:14 -0700
> From: Larry McVoy <lm@bitmover.com>
> To: Hugo Mills <hugo-lkml@carfax.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
>      bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
> Subject: Re: bk-3.2.0 released
>
> >    It'll allow BK to be run on machines which have a pure 64-bit
> > userspace (for example, Debian's current amd64 port), without having
> > to resort to a 32-bit chroot to run the 32-bit BK binary.
>
> OK, I found a reasonable looking box at
>
>     http://www.bzboyz.com/store/product4170.html
>
> ASUS K8V basic, AMD 64 2800+, $346.  Gotta love hardware prices.
>
> Next question is what distro you'd prefer to be the build OS.
> We typically use Red Hat, in this case that would be Fedora Core 1.
> Since that was one of the first (?) distros for x86-64 there shouldn't
> be any libc issues, right?  What we want is to use the _oldest_ possible
> distro/libc that works going forward.  So is Fedora 1 OK with you?  Any
> nay sayers?
> --
> ---
> Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
