Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVD3WCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVD3WCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 18:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVD3WCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 18:02:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:11668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261442AbVD3WCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 18:02:45 -0400
Date: Sat, 30 Apr 2005 14:59:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/tty_io.c: make a function static
Message-Id: <20050430145907.2a6b9c95.akpm@osdl.org>
In-Reply-To: <20050430200827.GT3571@stusta.de>
References: <20050430200827.GT3571@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch makes a needlessly global function static.
> 
> ...
>  -extern int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
>  -			      const char *routine);

Is used in fs/compat_ioct.c.
