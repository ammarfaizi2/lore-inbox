Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbTG0QTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTG0QTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:19:39 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:51725 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270856AbTG0QSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:18:49 -0400
To: Ren <l.s.r@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Inline vfat_strnicmp()
References: <20030727172150.15f8df7f.l.s.r@web.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 28 Jul 2003 01:33:58 +0900
In-Reply-To: <20030727172150.15f8df7f.l.s.r@web.de>
Message-ID: <87wue4udxl.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ren <l.s.r@web.de> writes:

> the function vfat_strnicmp() has just one callsite. Inlining it
> actually shrinks vfat.o slightly.

Thanks. I'll submit this patch to Linus.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
