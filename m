Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284198AbRLKXlf>; Tue, 11 Dec 2001 18:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284217AbRLKXl0>; Tue, 11 Dec 2001 18:41:26 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:59306 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284198AbRLKXlL>; Tue, 11 Dec 2001 18:41:11 -0500
Date: Tue, 11 Dec 2001 18:41:09 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de,
        Big Fish <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
Message-ID: <20011211184109.I6878@redhat.com>
In-Reply-To: <20011211162639.F6878@redhat.com> <Pine.LNX.4.21.0112112324280.981-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112112324280.981-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Dec 11, 2001 at 11:33:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:33:32PM +0000, Hugh Dickins wrote:
> Looks nice, but I think you need to update from atomic_inc(&map->count)
> and __free_page(map) to page_cache_get(map) and page_cache_release(map)?
> I haven't checked a 2.5.1-pre9 tree, but we had to change that in 2.4,
> to avoid PageLRU BUGs.  page_cache_get end just tidiness, of course.

Ahhh, that's something I've missed since our internal tree is still 2.4.9-ac 
based.  Thanks,

		-ben
-- 
Fish.
