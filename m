Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTLCNRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTLCNRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:17:23 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:58119 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264505AbTLCNRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:17:22 -0500
To: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAT fs sanity check patch
References: <20031203072219F.yokota@netlab.is.tsukuba.ac.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 03 Dec 2003 22:17:15 +0900
In-Reply-To: <20031203072219F.yokota@netlab.is.tsukuba.ac.jp>
Message-ID: <87d6b6ujl0.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp> writes:

>  Hello,
> 
>  This patch is required for my 640MB Optical disk.
> Because some MS windows based FAT filesystem disk formatter generetes
> wrong super bloacks.

[...]

> +	} else if (media == 0xf0 && FAT_FIRST_ENT(sb, 0xf8) == first) {

Thanks. I'll submit this patch.

BTW, did this happen in MS windows of which version?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
