Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268645AbRGZSdL>; Thu, 26 Jul 2001 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268646AbRGZSdB>; Thu, 26 Jul 2001 14:33:01 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:2716 "EHLO e22.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268645AbRGZScy>;
	Thu, 26 Jul 2001 14:32:54 -0400
Date: Thu, 26 Jul 2001 14:32:48 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <9jpftj$356$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107261429190.19887-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Linus Torvalds wrote:

> In article <E15PnTJ-0003z0-00@the-village.bc.nu>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >> Go tell your opinion to those people that refuse to wrap their
> >> rename/link calls with open()/fsync() calls to the respective parents,
> >> particularly Daniel J. Bernstein, Wietse Z. Venema, among others. I
> >> don't possibly know all MTAs.

[snip]
> Also, I think he eventually agreed on the logic of fsync() on the
> directory, and we even had a bug report (quickly fixed) for reiserfs
> because it got confused by it.

In looking at the synchronous directory options, I'm unsure as to
the 'real' status wrt fsync() on a directory:
	1) Does fsync() of a directory work on most/all current FS?
	2) Does it work on 2.2.x as well as 2.4.x?
-- 
Rick Nelson
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
	-- found in the .sig of Rob Riggs, rriggs@tesser.com

