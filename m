Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTJTJtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbTJTJtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:49:49 -0400
Received: from [65.172.181.6] ([65.172.181.6]:5298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbTJTJtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:49:47 -0400
Date: Mon, 20 Oct 2003 02:49:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: dev@sw.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Message-Id: <20031020024942.01094ff0.akpm@osdl.org>
In-Reply-To: <200310201340.48681.dev@sw.ru>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<200310201340.48681.dev@sw.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Hi!
> 
> > -invalidate_inodes-speedup.patch
> > -invalidate_inodes-speedup-fixes.patch
> Why did you decide to drop these patches out instead of adding fix for them?
> 

I would have had to get down, sort out what the heck is happening,
completely review and test these patches.  It's not a thing which
I want to be spending time on now.

If someone wants to send me a complete, documented and well-tested patch
then I can drop it in for testing, with a view to merge post-2.6.0.

(I'm also not particularly happy about adding eight(sixteen) bytes to every
inode just to speed up unmount.  It's worth thinking about alternatives,
although there are few).

