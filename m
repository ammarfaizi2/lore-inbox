Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbULaAIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbULaAIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULaAIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:08:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:6341 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261788AbULaAHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:07:54 -0500
Date: Fri, 31 Dec 2004 01:19:03 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Richard McCreedy <rick@mccreedy.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile error in 2.6.10-bk3 in floppy.c
In-Reply-To: <200412301507.50980.rick@mccreedy.us>
Message-ID: <Pine.LNX.4.61.0412310117360.3494@dragon.hygekrogen.localhost>
References: <200412301507.50980.rick@mccreedy.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004, Richard McCreedy wrote:

> drivers/block/floppy.c: In function `init_module':
> drivers/block/floppy.c:4598: error: syntax error before "UTS_RELEASE"
> make[2]: *** [drivers/block/floppy.o] Error 1
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2

Problem is known and a patch has been written - see thread with subject 
"[BK PATCH] fix floppy build" .


-- 
Jesper Juhl

