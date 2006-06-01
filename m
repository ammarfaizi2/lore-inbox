Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWFAJnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWFAJnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFAJnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:43:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750842AbWFAJnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:43:12 -0400
Date: Thu, 1 Jun 2006 11:45:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060601094518.GS29535@suse.de>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <1149154233.12777.14.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149154233.12777.14.camel@Homer.TheSimpsons.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2006, Mike Galbraith wrote:
> On Thu, 2006-06-01 at 01:48 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > 
> > 
> > - A cfq bug was fixed in mainline, so the git-cfq tree has been restored.
> 
> I put the fix for slab corruption into mm1, and it did indeed cure that.
> However, if I add git-cfq.patch, my box still explodes.

Andrew, you probably want to leave out git-cfq for a few days as it'll
throw rejects once Linus pulls the for-2.6.17 cfq urgent fixes. I'll
fixup the branch and the apparently silly bug that crept in that branch
and give you a ping about when to reenable it!

-- 
Jens Axboe

