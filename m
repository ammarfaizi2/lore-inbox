Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSGXTvH>; Wed, 24 Jul 2002 15:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317531AbSGXTvH>; Wed, 24 Jul 2002 15:51:07 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29304 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317525AbSGXTvG>; Wed, 24 Jul 2002 15:51:06 -0400
Date: Wed, 24 Jul 2002 21:55:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: David F Barrera <dbarrera@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0, mode:0x0
Message-ID: <20020724195503.GD1180@dualathlon.random>
References: <OF58871EFC.4272F3EB-ON85256C00.004B3677@pok.ibm.com> <3D3F019A.80BC3632@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3F019A.80BC3632@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 12:35:54PM -0700, Andrew Morton wrote:
> And please drop the ptrace.c change and use
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.27/lru-removal.patch
> instead.

page_cache_release() can return a #define to __free_page().

Andrea
