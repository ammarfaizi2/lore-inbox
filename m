Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272467AbRIOSJa>; Sat, 15 Sep 2001 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272462AbRIOSJU>; Sat, 15 Sep 2001 14:09:20 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:40402 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S272485AbRIOSJR>; Sat, 15 Sep 2001 14:09:17 -0400
Date: Sat, 15 Sep 2001 11:09:24 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Steven Spence <kwijibo@zianet.com>
cc: <DevilKin@gmx.net>, <linux-kernel@vger.kernel.org>
Subject: Re: AGP Bridge support for AMD 761
In-Reply-To: <3BA2B1DA.8050208@zianet.com>
Message-ID: <Pine.LNX.4.33.0109151108510.26946-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Sep 2001, Steven Spence wrote:

> DevilKin wrote:
>
> >Hello all...
> >
> >I've recently bought a new mobo, the Abit KG7-Raid, and I've run into some trouble trying to get the agpgart to work correctly. Everytime I load it
> >on kernel 2.4.9 (nonpatched, straigt from the tarball) I get messages like 'Unsupported chipset; try try_unsupported' (or smthing, not entirely
> >sure about the msg anymore since I'm not on that PC right now). I've tried what it advices, but still it keeps on giving that error.
> >
> >Anyone got a clue?
> >
> >Thanks,
> >
> >Devil
> >
> Well, do what its telling you.  Either append 'agp_try_unsupported' to
> lilo or use it as an option on modules.
>
> Ex: modprobe agpgart agp_try_unsupported=1

I've found, with 2.4.9(-ac9), that the lilo append line doesn't work at
all.  agpgart *must* be a modules, or it won't work with 761.

-jwb

