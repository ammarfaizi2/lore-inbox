Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbSI1Avc>; Fri, 27 Sep 2002 20:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSI1Avc>; Fri, 27 Sep 2002 20:51:32 -0400
Received: from [209.195.52.32] ([209.195.52.32]:19405 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S262663AbSI1Avb>; Fri, 27 Sep 2002 20:51:31 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Scott Murray <scottm@somanetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2002 17:48:10 -0700 (PDT)
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <Pine.LNX.4.44.0209270330350.338-100000@serv>
Message-ID: <Pine.LNX.4.44.0209271741410.25694-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will say that anything that requires more after-the-fact matching of
files on disk to the running system strikes me as a very bad idea.

I have had to do to many really ugly things with boot disks and old system
images just to keep things running at different times, I don't want to
make ANY assumptions that the currently running kernel+modules match
anything on the system.

I'm also the type that wants to compile monolithic kernels if possible to
eliminate any posibility of module mismatches so this is something that
I'll probably only use on my laptop so take it for what little it's worth
:-)

I've also been burned a few times by old utilities on a system when
installing a new kernel (I had a system running for a couple years where
ifconfig reported tx packets in the tx errors slot after an upgrade) and
anything that can reduce the possiblity of this is good.

David Lang

On Fri, 27 Sep 2002, Roman Zippel wrote:

> Date: Fri, 27 Sep 2002 03:34:56 +0200 (CEST)
> From: Roman Zippel <zippel@linux-m68k.org>
> To: Scott Murray <scottm@somanetworks.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] In-kernel module loader 1/7
>
> Hi,
>
> On Thu, 26 Sep 2002, Scott Murray wrote:
>
> > > Hmm, no comments about the proposed module layout? I suppose you believe
> > > me now, that a small and simple userspace insmod is possible. :)
> >
> > You'll be waiting a while for a response:
>
> Well, it seems that's a chance for someone else to jump into the
> discussion. :)
> Rusty's patch will have quite some impact on the kernel, so that I'm
> wondering, why there are not more comments about it.
>
> bye, Roman
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
