Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbRE3Wv1>; Wed, 30 May 2001 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262869AbRE3WvR>; Wed, 30 May 2001 18:51:17 -0400
Received: from wisdn-0.gus.net ([208.146.196.17]:33296 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S262868AbRE3WvH>; Wed, 30 May 2001 18:51:07 -0400
Date: Wed, 30 May 2001 15:50:20 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Harald Welte <laforge@gnumonks.org>, CML2 <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: Remaining undocumented Configure.help symbols
In-Reply-To: <20010530182012.D1305@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0105301543560.11050-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Eric S. Raymond wrote:

> Harald Welte <laforge@gnumonks.org>:
> > On Tue, May 29, 2001 at 02:59:40PM -0400, Eric S. Raymond wrote:
> >
> > > CONFIG_NET_CLS_TCINDEX
> >
> >   If you say Y here, you will be able to classify outgoing packets
> >   according to the tc_index field of the skb. You will want this
> >   feature if you want to implement Differentiates Services useing
> >   sch_dsmark. If unsure, say Y.

Change "useing" to "using". ;)

Change "Differentiates" to "Differentiated" (at least according to
./net/sched/sch_dsmark.c).

> >   This code is also available as a module called cls_tcindex.o ( = code
> >   which can be inserted in and removed from the running kernel
> >   whenever you want). If you want to compile it as a module, say MM

Shouldn't this be "say M" (and not "say MM")?

> >   here and read Documentation/modules.txt
>
> Looks good.
>
> > > CONFIG_NET_SCH_INGRESS
> >
> >   If you say Y here, you will be able to police incoming bandwidth
> >   and drop packets when this bandwidth exceeds your desired rate.
> >   If unsure, say Y.
> >
> >   This code is also available as a module called cls_tcindex.o ( = code
> >   which can be inserted in and removed from the running kernel
> >   whenever you want). If you want to compile it as a module, say MM

Shouldn't this be "say M"?

> >   here and read Documentation/modules.txt


