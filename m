Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbTIJWgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbTIJWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:36:28 -0400
Received: from zok.SGI.COM ([204.94.215.101]:31926 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265877AbTIJWeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:34:44 -0400
Date: Wed, 10 Sep 2003 15:34:30 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-ID: <20030910223430.GA18244@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030910213602.GC17266@sgi.com> <20030910151254.52f53e62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910151254.52f53e62.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 03:12:54PM -0700, Andrew Morton wrote:
> I think.  We could just say "dang numaq needs five bits", so:
> 
> 
> 	#if BITS_PER_LONG == 32
> 	#define ZONE_SHIFT 5
> 	#else
> 	#define ZONE_SHIFT 10
> 	#endif

That's fine with me, do you want me to rediff and send a new patch?

Thanks,
Jesse
