Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbULJXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbULJXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbULJXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:21:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:49045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbULJXV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:21:56 -0500
Date: Fri, 10 Dec 2004 15:25:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pawe__ Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10rc3+cset == oops (fs).
Message-Id: <20041210152555.5c579892.akpm@osdl.org>
In-Reply-To: <200412102330.02459.pluto@pld-linux.org>
References: <200412102330.02459.pluto@pld-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawe__ Sikora <pluto@pld-linux.org> wrote:
>
> I've just tried to boot the 2.6.10rc3+cset20041210_0507.
> 
> [handcopy of the ooops]
> 
> dereferencing null pointer
> eip at: radix_tree_tag_clear
> 
> trace:
> (...)
> test_clear_page_dirty
> truncate_complete_page
> truncate_inode_pages_range
> truncate_inode_pages
> generic_delete_inode
> sys_unlink
> initrd_load
> prepare_namespace
> (...)

I can't think of any recent changes whish could cause something like this. 
Is this reproducible?  If so, could you please work out which kernel
version and bk snapshot introduced the bug?  Thanks.
