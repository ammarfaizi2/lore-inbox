Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbQKJNxM>; Fri, 10 Nov 2000 08:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130822AbQKJNxC>; Fri, 10 Nov 2000 08:53:02 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:34969 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129764AbQKJNwm>; Fri, 10 Nov 2000 08:52:42 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: richardj_moore@uk.ibm.com, Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 10 Nov 2000 06:37:48 -0800 (PST)
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <Pine.GSO.4.21.0011100831210.12920-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011100636260.11307-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how is that any different then a module? modules that are not included
with the kernel source are not guarenteed to work with any other kernel
version (including during the stable kernel series)

David Lang

On Fri, 10 Nov 2000, Alexander Viro wrote:

> On Fri, 10 Nov 2000 richardj_moore@uk.ibm.com wrote:
> 
> > > The problem with the hooks et.al. is very simple - they promote every
> > > bloody implementation detail to exposed API. ....
> > 
> > Surely not, having the kernel source does that. The alternative to the hook
> > is embed a patch in the kernel source.  What proveds greater exposure to
> > internals: hooks of source?
> 
> Sorry. You don't "embed" the patch. You either get it accepted or not.
> Or you fork the tree and then it's officially None Of My Problems(tm).
> If your private patch breaks because of the kernel changes - too fscking
> bad, it's still None Of My Problems(tm). With hooks you have a published
> API.
> 
> Alternative to hook is not a random patch. It's finding a way to use public
> APIs (possibly at the cost of redesigning your code) or finding good arguments
> for changing said APIs (ditto). And they'ld better be really good. "I don't
> know how to do that without rethinking my code" doesn't cut it. Deal. There
> is _no_ warranty that anything other than public APIs will not change at any
> random moment. Period. You play with layering violations - you _will_ shoot
> yourself in foot. It's not "if", it's "when".
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
