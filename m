Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUKRW7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUKRW7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUKRW5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:57:03 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51620 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262959AbUKRWvY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:51:24 -0500
Message-Id: <200411182251.iAIMpHWY016873@turing-police.cc.vt.edu>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2 
In-reply-to: Your message of "Thu, 18 Nov 2004 02:15:38 PST."
             <20041118021538.5764d58c.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20041118021538.5764d58c.akpm@osdl.org>
Date: Thu, 18 Nov 2004 17:51:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 02:15:38 PST, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.
10-rc2-mm2/
> 
> - Lots of small bugfixes.  Some against patches in -mm, some against Linus's
...
> +selinux-atomic_dec_and_test-bug.patch
> 
>  Fix the SELinux scalability patches in -mm

This one was apparently the cause of my massive message flooding the other day.
At least, a -rc2-mm1 without it spews msgs, and a -rc2-mm1 with it doesn't.

Will try -rc2-mm2 tonight...

