Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUGCEXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUGCEXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 00:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUGCEXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 00:23:06 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:23563 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265065AbUGCEXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 00:23:03 -0400
To: <Andries.Brouwer@cwi.nl>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat/inode.c
References: <UTC200407021828.i62ISse29171.aeb@smtp.cwi.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 03 Jul 2004 13:22:39 +0900
In-Reply-To: <UTC200407021828.i62ISse29171.aeb@smtp.cwi.nl>
Message-ID: <871xjt4t4g.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Andries.Brouwer@cwi.nl> writes:

> Two years ago, OGAWA Hirofumi removed some ugly code and
> added a few simple tests to the FAT filesystem code,
> intended to avoid recognizing non-FAT as FAT (for people who
> fail to specify rootfstype=, forcing the kernel to guess).

Yes.

> That worked fairly well, until this year.
> I have now seen a thread in Czech and a report from Holland
> that involved the "FAT: bogus sectors-per-track value"
> error message.
> 
> The patch below removes this test again. The advantage is that
> some real-life FAT filesystems can be mounted again.
> The disadvantage that more non-FAT fss will be accepted as FAT.
> 
> Ferry van Steen <freaky@bananateam.nl> reports
> "the patch Andries Brouwer gave me seems to work".

Sounds good. Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
