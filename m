Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLXPj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTLXPj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:39:26 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:13185 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S263645AbTLXPjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:39:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Date: Wed, 24 Dec 2003 10:39:21 -0500
User-Agent: KMail/1.5.1
References: <20031222211131.70a963fb.akpm@osdl.org>
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312241039.21747.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.56.244] at Wed, 24 Dec 2003 09:39:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 00:11, Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-
>test11/2.6.0-mm1/
>
>
>Quite a lot of new material here.  It would be appreciated if people
> who have significant patches in -mm could retest please.

I don't have anything in -mm1, but heres a report, up about 23 hrs 
now.

Everything seems to be working fine, and one proggy I couldn't run 
before, now does, epsons iscan-1.5.2 front end for sane driven 
scanners now works.  The major thing I see in the logs is audio 
related, and has been carrying on since last summer.

Dec 23 20:35:18 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 21:33:06 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 22:10:50 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 22:25:58 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 22:50:40 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 23:20:37 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 23:33:07 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 23 23:53:43 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 24 00:07:46 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 24 00:22:26 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 24 01:22:55 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 24 01:35:27 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 24 03:47:31 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)
Dec 24 03:59:54 coyote kernel: via82cxxx: timeout while reading AC97 
codec (0x9A0000)

I think that each of those is related to the little two tone noise I 
play when there is new incoming mail.  There's a couple of other 
non-show stoppers but thats the major log clutterer.  The only alsa 
is whats in the kernel, and with a couple of very minor exceptions, 
it all works.  No Ooops, lockups or anything like that.  All pretty 
smooth and interactive using anticipatory at the moment.

Merry Christmas Andrew!

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

