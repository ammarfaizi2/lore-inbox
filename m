Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbUK3ASa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUK3ASa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUK3AS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:18:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:29854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261881AbUK3AS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:18:27 -0500
Date: Mon, 29 Nov 2004 16:18:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: stanojr@blackhole.websupport.sk
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>
Subject: Re: quota deadlock
Message-Id: <20041129161801.23883a03.akpm@osdl.org>
In-Reply-To: <20041112173118.GC17928@blackhole.websupport.sk>
References: <20041112173118.GC17928@blackhole.websupport.sk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stanojr@blackhole.websupport.sk wrote:
>
> heavy write access to partition with quota enabled causes deadlock. if
>  processes try to access the deadlocked partition they                    
>  simply have no response and cannot be killed with SIGKILL. i've been
>  testing with reiserfs and ext2 on 2.6.9 kernel.

There are a bunch of patches in 2.6.10-rc2-mm3 which are designed to fix
quota deadlocks.  Could you please test that (or a later -mm kernel) and
let us know the result?

Thanks.
