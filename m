Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWAKAZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWAKAZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWAKAZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:25:45 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:59338 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932359AbWAKAZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:25:44 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2G memory split
Date: Wed, 11 Jan 2006 11:25:53 +1100
User-Agent: KMail/1.8.2
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20060110125852.GA3389@suse.de> <17347.47882.735057.154898@alkaid.it.uu.se> <Pine.LNX.4.61.0601102141570.16049@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601102141570.16049@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111125.53357.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 07:42 am, Jan Engelhardt wrote:
> >2G/2G is not the only viable alternative. On my 1GB x86 box I'm
> >using "lowmem1g" patches for both 2.4 and 2.6, which results in
> >2.75G for user-space. I'm sure others have other preferences.
> >Any standard option for this should either have several hard-coded
> >alternatives, or should support arbitrary values (within reason).
> >
> >(See http://www.csd.uu.se/~mikpe/linux/patches/*/patch-i386-lowmem1g-*
> >if you're interested.)
>
> Hm, Con Kolivas also provided a lowmem1g patch in his set...

I was under the impression that breaking the ABI was a nono and such a patch 
would never be considered for mainline. Guess I was wrong. However mine only 
offered a split suitable for 1GB of ram whereas this is offering all that and 
steak knives too.

Cheers,
Con
