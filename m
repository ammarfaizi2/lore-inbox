Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbUKKKLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUKKKLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 05:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbUKKKLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 05:11:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:57042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262089AbUKKKLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 05:11:16 -0500
Date: Thu, 11 Nov 2004 02:11:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Magnus Damm <damm@opensource.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041111021103.1573601f.akpm@osdl.org>
In-Reply-To: <1100167792.8525.8.camel@localhost>
References: <20041111012333.1b529478.akpm@osdl.org>
	<1100167792.8525.8.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <damm@opensource.se> wrote:
>
> It looks like the file "usr/initramfs_list" gets removed when applying
>  the broken out patches (by "linux.patch") but the file is not removed
>  when the combined patch is applied...

Can't do anything about that.  The file exists in -rc1, is removed by
linus.patch and is created at build time when you build the post-rc1
kernel.

In other words: you have to remove that file prior to unpatching.

The problem will go away once -rc2-mm1 comes out.
