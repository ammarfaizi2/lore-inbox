Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSHNLPT>; Wed, 14 Aug 2002 07:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSHNLPT>; Wed, 14 Aug 2002 07:15:19 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:57049 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S316573AbSHNLPS>; Wed, 14 Aug 2002 07:15:18 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jos Hulzink <josh@stack.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Date: Wed, 14 Aug 2002 04:12:18 -0700 (PDT)
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <20020814115944.Q22573-100000@toad.stack.nl>
Message-ID: <Pine.LNX.4.44.0208140409320.14642-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while we're tweaking config options how about one that will turn on all
the features that fall into the catagory of 'if you have this it will
speed up your system, if you don't there's no performance penalty'

I definantly understand why some people will want to turn those off to
save memory, but it would be nice to have one thing to do to turn them all
on at once when memory isn't that tight.

David Lang

On Wed, 14 Aug 2002, Jos Hulzink wrote:

> Date: Wed, 14 Aug 2002 12:10:34 +0200 (CEST)
> From: Jos Hulzink <josh@stack.nl>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Martin J. Bligh <Martin.Bligh@us.ibm.com>,
>      linux-kernel <linux-kernel@vger.kernel.org>,
>      Matt Dobson <colpatch@us.ibm.com>
> Subject: Re: [PATCH] NUMA-Q disable irqbalance
>
> On Tue, 13 Aug 2002, Linus Torvalds wrote:
>
> > There are tons of reasons to run the same kernel on a multitude of
> > machines, even ignoring the issue of things like installers etc.
> >
> > We had this CONFIG_xxxx disease when it came to SSE, we had it when it
> > came to TSC, etc. And in every case it ended up being bad, simply because
> > it's not the right interface for _users_.
>
> True, but the nice thing about the linux kernel is that every little
> detail can be modified as you like. I think it is very important to answer
> the question what skills a person that wants to compile a kernel needs. If
> you want to lower the threshold, this sure is an config option that
> shouldn't be there.
>
> Maybe the config system should provide an expert-mode to tweak stuff like
> this, and enable / disable the irq balancing by default according to the
> processor type selected.
>
> Jos
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
