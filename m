Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSGWNEF>; Tue, 23 Jul 2002 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSGWNEF>; Tue, 23 Jul 2002 09:04:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14534 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S318058AbSGWNDf>; Tue, 23 Jul 2002 09:03:35 -0400
Date: Tue, 23 Jul 2002 15:05:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dave Jones <davej@suse.de>
cc: Benjamin LaHaise <bcrl@redhat.com>, Marcin Dalecki <dalecki@evision.ag>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 enum
In-Reply-To: <20020723142704.B14323@suse.de>
Message-ID: <Pine.SOL.4.30.0207231503300.14042-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Dave Jones wrote:

> On Mon, Jul 22, 2002 at 04:01:18PM -0400, Benjamin LaHaise wrote:
>  > On Mon, Jul 22, 2002 at 12:53:21PM +0200, Marcin Dalecki wrote:
>  > > - Fix a bunch of places where there are trailing "," at the
>  > >    end of enum declarations.
>  >
>  > Please don't apply this.  By leaving the trailing "," on enums, additional
>  > values can be added by merely inserting an additional + line in a patch,
>  > otherwise there are excess conflicts when multiple patches add values to
>  > the enum.
>
> Gratuitous 'cleanups' with no real redeeming feature also have another
> downside which a lot of people seem to overlook.  They completely screws
> over anyone who also has a pending patch in that area if Linus applies it.
>
> For most people this is five minutes work as they fix up by hand
> the single reject in one or two places.  For people like myself keeping
> a large patchset, this is a lot of extra work for absolutely no gain.
> Two kernels later, someone adds a new sysctl which re-adds the , at
> the end anyway.

Now imagine my pain keeping in sync with IDE 2.5 or even
reviewing IDE patches...

Regards
--
Bartlomiej

> We have much bigger problems to fix than silly[1] things like this.
>
>         Dave
>
> [1] Maybe silly is the wrong word to use, but I didn't want to use
>     'trivial' for fear of putting down the usefulness of Rusty's
>     trivial patches.
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

