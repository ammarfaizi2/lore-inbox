Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUCKQlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUCKQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:41:15 -0500
Received: from topaz.cx ([66.220.6.227]:11970 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S261516AbUCKQlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:41:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0) 
X-Newsgroups: linux.kernel
In-Reply-To: <1yALu-288-5@gated-at.bofh.it>
From: chip@pobox.com (Chip Salzenberg)
References: <1y5oc-8cr-1@gated-at.bofh.it> <1ygjH-3LE-31@gated-at.bofh.it> <1ygMH-4eu-21@gated-at.bofh.it> <1yzZ9-1qq-43@gated-at.bofh.it> <1yAs0-1P6-7@gated-at.bofh.it>
Organization: NASA Calendar Research
Message-Id: <E1B1TFB-0007T8-Ss@tytlal>
Date: Thu, 11 Mar 2004 11:41:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:
>+       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))

I remember that.  I wasn't scanning changes, but when it was shown up
in the news stories, I wasn't visually fooled for even a second.  You
can't code in C for decades without picking up good = vs. == radar.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
