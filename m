Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUKBX5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUKBX5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKBX5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:57:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:60904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263006AbUKBX4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:56:16 -0500
Date: Tue, 2 Nov 2004 16:54:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill the last few warnings in binfmt_elf.c
Message-Id: <20041102165422.4c09aad7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0411030039310.3395@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411030039310.3395@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> Sorry to keep bugging you with this directly, but I'm still not aware of a 
>  sepperate maintainer for this file.

There isn't one.

> 
>  I've send you 3 patches previously that kill a few warnings in 
>  fs/binfmt_elf.c. The patch below includes those previous 3 and also adds a 
>  fix for the last ones.

The other patches are still queued up in my todo queue.  This is because I
took a close look at these warnings some weeks ago and ended up deciding
that the proper fixes were complex and risky.  So I need to go through your
patches with some care.  I hope you've already done so.
