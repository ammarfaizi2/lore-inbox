Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUKOUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUKOUWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbUKOUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:22:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:4750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261674AbUKOUUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:20:18 -0500
Date: Mon, 15 Nov 2004 12:20:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2
Message-Id: <20041115122003.2be7162f.akpm@osdl.org>
In-Reply-To: <4198991C.6060203@yahoo.com.au>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
	<4198991C.6060203@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> I'd like to get included that patch to restore the buffer of memory
>  reserved for GFP_ATOMIC allocations (ie. the difference between GFP_KERNEL
>  and GFP_ATOMIC allocations).
> 
>  http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/mm-restore-atomic-buffer.patch
> 
>  It is not actually a regression versus 2.6.9 (it is vs 2.6.8), although I
>  think it is responsible for the increased reports of page allocation failures.
> 
>  It would be nice to let it have more testing in -mm first, but OTOH if we
>  _really_ want it in 2.6.10 it would make sense to merge it ASAP so it can get
>  wider testing.
> 
>  Any feelings on the matter yet, Andrew? Or were you thinking it would be OK for
>  post 2.6.10?

That one should be in 2.6.10, yes.
