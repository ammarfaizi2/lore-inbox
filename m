Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUAGT0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUAGT0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:26:36 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:33791 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S266227AbUAGTZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:25:32 -0500
Date: Wed, 7 Jan 2004 11:27:33 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040107192732.GA13240@gaz.sfgoth.com>
References: <20040106054859.GA18208@waste.org> <20040107140640.GC16720@suse.de> <20040107185039.GC18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107185039.GC18208@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> When I merge
> CONFIG_BLOCK, it'll be more generally useful.

Maybe it would make more sense to have CONFIG_MEMPOOL=n just remove
the mempool API entirely and have it imply CONFIG_BLOCK=n, CONFIG_NFS_FS=n,
and CONFIG_NFSD=n?  Just a thought.

It seems like a reasonalbe thing to omit for some tiny configs that don't
need it, but if the API is provided it should probably work as expected.

-Mitch
