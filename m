Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSGQSNq>; Wed, 17 Jul 2002 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGQSNp>; Wed, 17 Jul 2002 14:13:45 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:33725 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316185AbSGQSNp>;
	Wed, 17 Jul 2002 14:13:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 10/13] remove add_to_page_cache_unique()
Date: Wed, 17 Jul 2002 20:17:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D3500E2.9CB994A7@zip.com.au>
In-Reply-To: <3D3500E2.9CB994A7@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UtMs-0004Oi-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 07:30, Andrew Morton wrote:
> A tasty patch from Hugh Dickens.  radix_tree_insert() fails if something
> was already present at the target index, so that error can be
> propagated back through add_to_page_cache().  Hence
> add_to_page_cache_unique() is obsolete.
> 
> Hugh's patch removes add_to_page_cache_unique() and cleans up a bunch of
> stuff.

:-)  A large bouquet to Hugh, and another to Momchil Velikov for recoring the 
whole interface in the first place.

-- 
Daniel
