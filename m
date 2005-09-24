Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVIXPWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVIXPWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVIXPWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:22:36 -0400
Received: from silver.veritas.com ([143.127.12.111]:7021 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932154AbVIXPWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:22:35 -0400
Date: Sat, 24 Sep 2005 16:22:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/msync.c cleanup
In-Reply-To: <874q8amrrg.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.61.0509241619300.20256@goblin.wat.veritas.com>
References: <874q8amrrg.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Sep 2005 15:22:29.0191 (UTC) FILETIME=[C6B44D70:01C5C11B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, OGAWA Hirofumi wrote:
> 
> This is not problem actually, but sync_page_range() is using for
> exported function to filesystems.
> 
> The msync_xxx is more readable at least to me.
> 
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

How very confusing!  My fault, and thank you for fixing it.  Please apply.

Acked-by: Hugh Dickins <hugh@veritas.com>
