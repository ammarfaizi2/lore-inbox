Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVCGBii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVCGBii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVCGBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:38:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:31457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261441AbVCGBig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:38:36 -0500
Date: Sun, 6 Mar 2005 17:38:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: rml@novell.com, ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify for 2.6.11-mm1
Message-Id: <20050306173829.11856cb2.akpm@osdl.org>
In-Reply-To: <20050307011939.GA7764@infradead.org>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
	<1109963494.10313.32.camel@betsy.boston.ximian.com>
	<20050307011939.GA7764@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> -mm has a list of inodes per superblock, which Andrew said he'd send
> along to lines, you should probably use that one.

That was merged a month or two ago.

superblock.s_inodes, linked via inode.i_sb_list, protected by inode_lock.

