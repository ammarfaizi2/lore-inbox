Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWDCH2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWDCH2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWDCH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:28:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751600AbWDCH2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:28:52 -0400
Date: Mon, 3 Apr 2006 09:28:57 +0200
From: Jens Axboe <axboe@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove sys_ prefix of new syscalls from __NR_sys_*
Message-ID: <20060403072855.GD3770@suse.de>
References: <87k6a910fr.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6a910fr.fsf@duaron.myhome.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02 2006, OGAWA Hirofumi wrote:
> On i386, we don't use sys_ prefix for __NR_*. This patch removes it.
> [FWIW, _syscall*() macros will generate foo() instead of sys_foo().]
> 
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks, I'll just shove that into the splice branch.

-- 
Jens Axboe

