Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbUBWWrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUBWWrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:47:25 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:54401 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262024AbUBWWrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:47:24 -0500
Date: Mon, 23 Feb 2004 14:47:23 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-ID: <20040223224723.GA27639@dingdong.cryptoapps.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org> <40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au> <40396DA7.70200@cyberone.com.au> <4039B4E6.3050801@cyberone.com.au> <4039BE41.1000804@cyberone.com.au> <20040223005948.10a3b325.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223005948.10a3b325.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 12:59:48AM -0800, Andrew Morton wrote:

> We've never clearly defined whether pages_high == free_pages means
> the zone is under limits.  According to __alloc_pages() it means
> that the zone is not under limits, so you've fixed two bugs there.

FWIW 2.6.3-mm3 with the above fix right now seems to behave much
better in my non-contrived cases than previous kernels I've tested
with.


