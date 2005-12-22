Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVLVRfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVLVRfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVLVRfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:35:36 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:1472 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1030232AbVLVRff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:35:35 -0500
Message-ID: <43AADE4E.8060600@ens-lyon.org>
Date: Thu, 22 Dec 2005 12:11:42 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Michael Madore <michael.madore@gmail.com>,
       David Brownell <david-b@pacbell.net>, Greg KH <gregkh@suse.de>,
       paulmck@us.ibm.com, Gottfried Haider <gohai@gmx.net>,
       luca.risolia@studio.unibo.it, "P. Christeas" <p_christ@hol.gr>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051222011320.GL3917@stusta.de> <20051222005209.0b1b25ca.akpm@osdl.org> <20051222135718.GA27525@stusta.de>
In-Reply-To: <20051222135718.GA27525@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>>non-bugzilla post-2.6.14 bugs which I've squirelled away include:
>>
>>
>>From: Brice Goglin <Brice.Goglin@ens-lyon.org>
>>Subject: Linux 2.6.14: Badness in as-iosched
>>    
>>
>
>As the subject says, this is not a post-2.6.14 regression.
>
>Besides this, Jens (Cc'ed) sent a patch for it:
>  http://lkml.org/lkml/2005/11/20/119
>
>Was there a reason why it wasn't applied?
>  
>
Jens also posted a different patch on
http://lkml.org/lkml/2005/11/21/111 addressing my issue. It was supposed
to go in -stable. But, from I see in changelogs, nothing went into
-stable while something similar has been merged into rc3:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=43fa2049568883d6b5c07cc304b77c93d3091abf;hp=fbe050124ec514431c19091d395fa9065b2398a4;hb=8ad9ebb391e4cd75837ee608b9c33fcaceda0bc2;f=block/as-iosched.c

Anyway, I did not reproduce my problem with the first patch that Jens
sent (applied on top of 2.6.14). 2.6.15-rcX look fine too, but I am not
sure I have stressed those kernels as much as 2.6.14.

Brice

