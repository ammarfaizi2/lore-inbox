Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUFOUuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUFOUuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUFOUuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:50:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31881 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265938AbUFOUtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:49:09 -0400
Date: Tue, 15 Jun 2004 22:49:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Nigel Rantor <wiggly@wiggly.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom ripping / dropping to dingle frame dma
Message-ID: <20040615204908.GA12603@suse.de>
References: <40CF594C.30109@wiggly.org> <20040615203828.GA12504@suse.de> <40CF6053.3020105@wiggly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CF6053.3020105@wiggly.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2004, Nigel Rantor wrote:
> Jens Axboe wrote:
> >It did not, and it didn't fix the issue completely. My plan is to add a
> >counter just checking if we succeeded doing some dma ripping already,
> >in which case there's no point to falling back to lesser methods. That
> >should be way more reliable than checking sense and making up our on
> >rules based on that.
> >
> >I'll get a patch out tomorrow.
> 
> Cool, thanks for the reply. I'm quite happy to go to 2.6.7 if that's 
> what you'll be patching against.

I usually patch against current -BK, so if you run latest -bkX snapshot
you should be fine. The risk of rejects isn't too big in this area, so
2.6.7-rc3 should be adequate.

> Are you still looking for people who can reproduce this problem? If so 
> I'll try and find a couple of the CDs that I have that kill ripping now 
> on this kernel before applying any patches you come up with.

If you can find an easily reproducable test case to run on a patch,
that's certainly very helpful.

-- 
Jens Axboe

