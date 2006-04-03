Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWDCHdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWDCHdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWDCHdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:33:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45444
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751614AbWDCHdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:33:24 -0400
Date: Mon, 03 Apr 2006 00:32:29 -0700 (PDT)
Message-Id: <20060403.003229.131568711.davem@davemloft.net>
To: axboe@suse.de
Cc: hirofumi@mail.parknet.co.jp, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove sys_ prefix of new syscalls from __NR_sys_*
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060403072855.GD3770@suse.de>
References: <87k6a910fr.fsf@duaron.myhome.or.jp>
	<20060403072855.GD3770@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Mon, 3 Apr 2006 09:28:57 +0200

> On Sun, Apr 02 2006, OGAWA Hirofumi wrote:
> > On i386, we don't use sys_ prefix for __NR_*. This patch removes it.
> > [FWIW, _syscall*() macros will generate foo() instead of sys_foo().]
> > 
> > Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> Thanks, I'll just shove that into the splice branch.

Please update the other include/asm-*/unistd.h files which
use the same sys_* name.

Thanks.
