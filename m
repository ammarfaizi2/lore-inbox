Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314961AbSEHT3D>; Wed, 8 May 2002 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314838AbSEHT3C>; Wed, 8 May 2002 15:29:02 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:54021 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S314957AbSEHT3B>; Wed, 8 May 2002 15:29:01 -0400
Date: Wed, 8 May 2002 20:28:50 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Dax Kelson <dax@gurulabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1) 
In-Reply-To: <9176.1020865349@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0205082027360.14553-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 May 2002, Keith Owens wrote:

> On Wed, 8 May 2002 03:40:11 -0600 (MDT),
> Dax Kelson <dax@gurulabs.com> wrote:
> >Originally when a process set*uided all capabilities bits were cleared.
> >Then sometime later (wish BK went back 3 years), the behaviour was
> >modified according to the comment "A process may, via prctl(), elect to
> >keep its capabilites when it calls setuid() and switches away from
> >uid==0. Both permitted and effective sets will be retained."
>
> FWIW, the change was in 2.2.18-pre18, between October 26 and 29, 2000.

I did the original change in 2.3.x. Since it is so important to get useful
capability functionality, someone (Chris Wing?) backported the change to
2.2.x.

I'll reply to the original e-mail shortly..

Cheers
Chris


