Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSJYLoJ>; Fri, 25 Oct 2002 07:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJYLoI>; Fri, 25 Oct 2002 07:44:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44784 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261367AbSJYLoH>; Fri, 25 Oct 2002 07:44:07 -0400
Date: Fri, 25 Oct 2002 13:50:17 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Slavcho Nikolov <snikolov@okena.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: over&out (Re: feature request - why not make netif_rx() a
 pointer?)
In-Reply-To: <008b01c27ab0$760be900$800a140a@SLNW2K>
Message-ID: <Pine.NEB.4.44.0210251324570.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Slavcho Nikolov wrote:

>...
> Yes, many companies from time to time feed smaller or larger contributions
> back into the community.
> But they don't usually release *all* their modifications because they just
> might be irrelevant to everyone but a small niche of enterprise users.

It might be that a modification isn't of big interest for the majority of
users but:
- It might be interesting for people working in similar niches.
- E.g. several development boards are supported in the MIPS port in the
  standard Linux kernel. The niche of people using them isn't very big but
  this doesn't prevent the inclusion into the main kernel.

> | If you want to replace the messaging code, make a GPL'd kernel patch and
> | make it available to your clients (of course they can then publish it
> | all over the place if they so desire).  If those terms are not
> | acceptable, there's always BSD.
>
> It doesn't quite work that way. Big name distributors (e.g. Suse, Redhat)
> usually supply
> and support big customers with Linux distributions. Third parties usually
> supply modules.
> Integration of the two is demanded by the customer, so it's not our choice
> to
> use BSD or ask the end users that our patches be applied and their kernels
> recompiled.
> Certainly patches can be rolled out but it's a costly proposition
> (especially to customers)
> and requires a level of expertise and commitment on the part of the
> customers that
> may not be available.

But this doesn't prevent you from releasing the source code of your module
under the terms of the GPL.

> Nearly every storage or networking startup that uses Linux (hundreds of them
> exist)
> has tried to find hooks into the filesystems or network stacks, within the
> constraints
> of  modules and GPL. It isn't always easy to insert oneself where we want
> but they have found interesting solutions and work-arounds whether or not on
> the
> legal grounds are shaky.

The legal grounds become more shaky as soon as you consider that court
decisions might be different in different countries. If someone wants to
sue you he might have the possibility to choose between different
countries where he wants to sue you...  8)

> All I said was that it's good to make life easier for these startups.
> S.N.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


