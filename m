Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424439AbWKPUW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424439AbWKPUW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424441AbWKPUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:22:28 -0500
Received: from brick.kernel.dk ([62.242.22.158]:58891 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1424439AbWKPUW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:22:28 -0500
Date: Thu, 16 Nov 2006 21:21:57 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Edward Falk <efalk@google.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Introduce block I/O performance histograms
Message-ID: <20061116202156.GG7164@kernel.dk>
References: <455BD7E8.9020303@google.com> <20061116065846.GE32394@kernel.dk> <455CC38A.20104@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455CC38A.20104@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16 2006, Edward Falk wrote:
> Jens Axboe wrote:
> 
> >I don't see the point at all for including this piece of code in the
> >kernel. You can do the same from user space. Your help entry said it
> >even grows the kernel size about 21k, that's pretty nasty.
> 
> How would you do this from user space?  Also, the 21k increase is only 
> in effect if the feature is turned on in the config, and it's off by 
> default.

You can use blktrace to do it. I realize that the 21k is only if it's
turned out, it's still quite a huge big (why does it turn out so big?).
The source is always there to maintain, though. The main point is that
you don't have to do this in the kernel, though.

-- 
Jens Axboe

