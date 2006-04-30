Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWEAUaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWEAUaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEAUaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:30:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44043 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932228AbWEAUaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:30:24 -0400
Date: Sun, 30 Apr 2006 19:25:03 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Message-ID: <20060430192503.GE4452@ucw.cz>
References: <Pine.LNX.4.64.0604251112490.5810@localhost.localdomain> <20060425183026.GR4102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425183026.GR4102@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-04-06 20:30:26, Jens Axboe wrote:
> On Tue, Apr 25 2006, Hua Zhong wrote:
> > With likely/unlikely profiling (see the recent patch dwalker@mvista.com 
> > sent), on my not-so-busy-typical-development system it shows more than 
> > 80K misses and no hits. So I guess it makes sense to revert.
> > 
> > I don't know BIO code very well, but I hope this data is useful for the 
> > experts.
> 
> Well you'd want to optimize for the busy case, right, no point in
> optimizing for a more idle system.

Careful here... for battery-powered systems you may want to optimize
for idle system...
							Pavel
-- 
Thanks, Sharp!
