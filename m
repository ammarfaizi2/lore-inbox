Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUIEOfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUIEOfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUIEOfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:35:43 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:26642 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266745AbUIEOfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:35:42 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: rewrite the cache for file allocation table lookup
 (2/4)
References: <878ybpvtpz.fsf@devron.myhome.or.jp>
	<20040905123959.A29612@infradead.org>
	<87pt50vq01.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 05 Sep 2004 23:35:13 +0900
In-Reply-To: <87pt50vq01.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Sun, 05 Sep 2004 21:50:38 +0900")
Message-ID: <878ybog4wu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Christoph Hellwig <hch@infradead.org> writes:
>
>>> +#if 0
>>> +#define debug_pr(fmt, args...)	printk(fmt, ##args)
>>> +#else
>>> +#define debug_pr(fmt, args...)
>>> +#endif
>>
>> We have a pr_debug() in <linux/kernel.h> that you could use.
>
> I hated KERN_DEBUG. But, well, maybe pr_debug() was enough...
>
> I'll replace it for now

FAT: fat_cache_lookup, fclus 6<7>, fclus 1, dclus 325759, cont 5<7> (off 5, full hit)<7>

KERN_DEBUG was not readable. Sorry. I'd like to be puting it as is for now.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
