Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVIAPPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVIAPPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVIAPPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:15:42 -0400
Received: from smtp05.web.de ([217.72.192.209]:26292 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S1030191AbVIAPPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:15:41 -0400
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][RFC] vm: swap prefetch
Date: Thu, 1 Sep 2005 17:15:36 +0200
User-Agent: KMail/1.6.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200509012346.33020.kernel@kolivas.org>
In-Reply-To: <200509012346.33020.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200509011715.36430.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con!

Am Donnerstag, 1. September 2005 15:46 schrieb Con Kolivas:
> Here is a working swap prefetching patch for 2.6.13. I have resuscitated
> and rewritten some early prefetch code Thomas Schlichter did in late 2.5 to
> create a configurable kernel thread that reads in swap from ram in reverse
> order it was written out. It does this once kswapd has been idle for a
> minute (implying no current vm stress). This patch attached below is a
> rollup of two patches the current versions of which are here:
>
> http://ck.kolivas.org/patches/swap-prefetch/
>
> These add an exclusive_timer function, and the patch that does the swap
> prefetching. I'm posting this rollup to lkml to see what the interest is in
> this feature, and for people to test it if they desire. I'm planning on
> including it in the next -ck but wanted to gauge general user opinion for
> mainline. Note that swapped in pages are kept on backing store (swap),
> meaning no further I/O is required if the page needs to swap back out.

I am (and some of my friends are) still interested in this functionality, so 
I'm definitly going to test your improved patch, of course. By the way, I'm 
quite happy that you came up with this new version of swap-prefetching, 
because I didn't and still don't have the time to develop or maintain it 
more...

So thanks for your good work, and keep on helping Linux-Desktop-Users! :-)

  Thomas
