Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310361AbSCLCrl>; Mon, 11 Mar 2002 21:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCLCrb>; Mon, 11 Mar 2002 21:47:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310361AbSCLCrR>; Mon, 11 Mar 2002 21:47:17 -0500
Date: Mon, 11 Mar 2002 18:33:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D667F.5040208@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
> If filtering is done, I agree the filter feature is disable-able if the
> kernel builder / sysadmin desires such.  Disable the filter by default,
> if that's your fancy.  But let us filter.  :)

BUT WHAT THE HELL IS THE POINT?

Don't you get that? If the sysadmin can turn the filtering off, so can any
root program. And your worry seems to be the CRM kind of disk locking
utility which most _definitely_ would do exactly that if it is as evil as
you think it is.

And if you hardcode the filtering at compile-time in the kernel, that
means that you've now painted yourself into the corner that you already
seemed to admit was not a good idea - the same way it's not a good idea
for network filtering.

		Linus


