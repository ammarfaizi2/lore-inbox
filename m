Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTDEW0S (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTDEW0S (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:26:18 -0500
Received: from [12.47.58.55] ([12.47.58.55]:11664 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261876AbTDEW0R (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:26:17 -0500
Date: Sat, 5 Apr 2003 14:38:52 -0800
From: Andrew Morton <akpm@digeo.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slab corruption with ext3-handle-cache.patch
Message-Id: <20030405143852.67833364.akpm@digeo.com>
In-Reply-To: <1049580790.29758.8.camel@nosferatu.lan>
References: <1049580790.29758.8.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 22:37:45.0000 (UTC) FILETIME=[F9EC4280:01C2FBC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Schlemmer <azarah@gentoo.org> wrote:
>
> Hi
> 
> I tried this patch a few days again, but not in the mm patch set.  So
> when I got problems with slab corruption, I figured it was maybe a
> patch I missed, and dropped it.
> 
> Now with 2.5.66-bk10+, it is merged, and I get it again.
> 
> ----------------------------------------------------------
> Slab corruption: start=cfaeecc4, expend=cfaeee77, problemat=cfaeed28
> Last user: [<c01890de>](ext3_destroy_inode+0x1b/0x1f)
> Data:
> ****************************************************************************************************3C 26 99 DF *******************************************************************************************************************************************************************************************************************************************************************************************************************************************A5 

Do you have CONFIG_EXT3_FS_POSIX_ACL enabled?


