Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVJELdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVJELdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVJELdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:33:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19789 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965114AbVJELdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:33:44 -0400
Date: Wed, 5 Oct 2005 13:34:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, andersen@codepoet.org
Subject: Re: [PATCH] ide-cd mini cleanup of casts (mainly)
Message-ID: <20051005113413.GK3511@suse.de>
References: <200510040017.57168.jesper.juhl@gmail.com> <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com> <20051004062146.GD3511@suse.de> <200510050019.44256.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510050019.44256.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05 2005, Jesper Juhl wrote:
> On Tuesday 04 October 2005 08:21, Jens Axboe wrote:
> [snip]
> > This is a mess. So NACK on this patch. And why are you changing the
> [snip]
> 
> Hi Jens,
> 
> Sorry about the messy previous patch.  Would you consider something like the
> one below instead?  It only makes a few changes, not lots of different ones in
> the same patch and it also only makes changes that I hope you'll agree are 
> useful. :)
> 
> 
> Remove some unneeded casts.
> Avoid an assignment in the case of kmalloc failure.
> Break a few instances of  if (foo) whatever;  into two lines.

Looks much better, thanks.

-- 
Jens Axboe

