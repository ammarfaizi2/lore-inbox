Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVARBI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVARBI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVARBI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:08:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:1551 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261467AbVARBHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:07:13 -0500
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] FAT: Lindent fs/vfat/namei.c
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
	<877jmcne0o.fsf_-_@devron.myhome.or.jp>
	<873bx0ndze.fsf_-_@devron.myhome.or.jp>
	<87y8eslzdq.fsf_-_@devron.myhome.or.jp>
	<20050117191241.GD25205@speedy.student.utwente.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 10:06:56 +0900
In-Reply-To: <20050117191241.GD25205@speedy.student.utwente.nl> (Sytse
 Wielinga's message of "Mon, 17 Jan 2005 20:12:41 +0100")
Message-ID: <87is5vlf4f.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sytse Wielinga <s.b.wielinga@student.utwente.nl> writes:

>>   *  Support Multibyte character and cleanup by
>                                 ^^^ Shouldn't that be 'characters'?

Thanks.

Please apply the following incremental patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



[PATCH 15] FAT: Fix typo in comment

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/vfat/namei.c~fat_fix-typo fs/vfat/namei.c
--- linux-2.6.11-rc1/fs/vfat/namei.c~fat_fix-typo	2005-01-18 09:57:16.000000000 +0900
+++ linux-2.6.11-rc1-hirofumi/fs/vfat/namei.c	2005-01-18 09:57:16.000000000 +0900
@@ -11,7 +11,7 @@
  *
  *  Short name translation 1999, 2001 by Wolfram Pienkoss <wp@bszh.de>
  *
- *  Support Multibyte character and cleanup by
+ *  Support Multibyte characters and cleanup by
  *				OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
  */
 
_
