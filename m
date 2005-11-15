Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVKOKGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVKOKGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVKOKGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:06:45 -0500
Received: from barclay.balt.net ([195.14.162.78]:27486 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932333AbVKOKGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:06:44 -0500
Date: Tue, 15 Nov 2005 12:05:19 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051115100519.GA5567@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114162942.5b163558.akpm@osdl.org>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I am compiling the latest git snapshot 4060994c3e337b40e0f6fa8ce2cc178e021baf3d.
I will let you know if anything comes up.

Z.

On Mon, Nov 14, 2005 at 04:29:42PM -0800, Andrew Morton wrote:
> This looks like some sort of slab scribble, possibly caused by faulty
> error-path handling in the ipw2200 code.
> 
> Please enable CONFIG_DEBUG_SLAB and see if that picks anything up.
> 
> Also enable CONFIG_DEBUG_PAGEALLOC.
> 
> You may also get more info by setting CONFIG_IPW_DEBUG and loading the
> module with `debug=65535' (guess).
> 
> Whatever you do, don't fix the firmware loading failure (sorry).  Doing
> that will cause you to not be able to reproduce this bug ;)

Hmmm, I didn't see any problems related to f/w loading ...

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
