Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUK3DZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUK3DZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUK3DZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:25:06 -0500
Received: from ozlabs.org ([203.10.76.45]:55012 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261960AbUK3DZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:25:01 -0500
Subject: Re: [ANNOUNCE 3/7] Diskdump 1.0 Release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkdump-develop@lists.sourceforge.net
In-Reply-To: <3DC4D60005C89Bindou.takao@soft.fujitsu.com>
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
	 <3DC4D60005C89Bindou.takao@soft.fujitsu.com>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 14:24:54 +1100
Message-Id: <1101785094.14565.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 19:41 +0900, Takao Indoh wrote:
> This is a patch for ide-dump.
...
> +MODULE_AUTHOR("Nobuhiro Tachino <tachino@jp.fujitsu.com>");
> +MODULE_DESCRIPTION("IDE diskdump driver");
> +MODULE_LICENSE("GPL");
> +MODULE_PARM(no_io_32bit, "i");
> +MODULE_PARM(pio_mode, "i");

Please use the modern module_param()!

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

