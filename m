Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUKCCwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUKCCwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUKCCwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:52:38 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:30435 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261339AbUKCCwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:52:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: idr stuff
Date: Tue, 2 Nov 2004 22:52:35 -0400
User-Agent: KMail/1.7
Cc: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>
References: <1099330316.12182.2.camel@vertex> <1099340928.31022.46.camel@betsy.boston.ximian.com>
In-Reply-To: <1099340928.31022.46.camel@betsy.boston.ximian.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411022152.35244.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.44.149] at Tue, 2 Nov 2004 20:52:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 November 2004 15:28, Robert Love wrote:
>John.
>
>MAX_ID_MASK is already set to the maximum IDR value, so we don't
> need to add IDR_MAX_ID.  I know this was my idea--I was, uh, being
>metaphoric. :)
>
>Plus, MAX_ID_MASK is computed based on IDR_BITS, so it is "always
>right."
>
>Also add an IWATCHES_HARD_LIMIT, set to MAX_ID_MASK, instead of
> using MAX_ID_MASK directly.
>
>Finally, this uncovers that idr.h is not protected against double
>inclusion, so wrap it in ifndef's.
>
>Best,
>
> Robert Love

Anybody know whats going on, I just got 8 copies of this
[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
