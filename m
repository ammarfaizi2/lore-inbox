Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVIGBgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVIGBgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIGBgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:36:03 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:61448 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751172AbVIGBgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:36:02 -0400
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Remove duplicate directory scanning code
References: <1125836769.2185.1.camel@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 05 Sep 2005 23:59:03 +0900
In-Reply-To: <1125836769.2185.1.camel@localhost> (Pekka Enberg's message of "Sun, 04 Sep 2005 15:26:09 +0300")
Message-ID: <8764tf7e88.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> writes:

> This patch removes duplicate directory scanning code from fs/fat/dir.c. The
> two functions that share identical code are fat_readdirx() and
> fat_search_long(). This patch also renames fat_readdirx to __fat_readdir().

Thanks, looks good. However, I would like the _long rather than _extended.

But sorry, I have no time for reviewing all of patch now. I'll send it
to Andrew after review.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
