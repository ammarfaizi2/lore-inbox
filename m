Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316625AbSEQRgv>; Fri, 17 May 2002 13:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316626AbSEQRgu>; Fri, 17 May 2002 13:36:50 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65229 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316625AbSEQRgt>; Fri, 17 May 2002 13:36:49 -0400
Date: Fri, 17 May 2002 13:36:49 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205171736.g4HHant04061@devserv.devel.redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <mailman.1021642692.12772.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> We could do that, or, we could fix the actual problem, which is the
> HUGE FUCKING BEARTRAP WHICH CATCHES EVERY SINGLE NEW PROGRAMMER ON THE
> WAY THROUGH.

It is but one of many crooked interfaces. For example, Linux
has outb() arguments swapped relatively to all other environments.
I think it may be the best to have Corbet to update the O'Reily
book with a chapter of common traps and add a @-comment near
the copy_from_user.

In the interest of full disclosure, I must admit that I used
copy_from_user wrong once, many years ago. The lesson which
I extracted was different though. I decided that I was arrogant
and foolish to program without reading interface specifications
or the code. It did not occur to me to shift the blame onto
copy_from_user creators.

-- Pete
