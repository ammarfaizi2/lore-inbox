Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVIHIpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVIHIpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVIHIpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:45:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932242AbVIHIpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:45:04 -0400
Date: Thu, 8 Sep 2005 01:44:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
Message-Id: <20050908014436.6edd2f53.akpm@osdl.org>
In-Reply-To: <431FC7DA.6090309@comcast.net>
References: <431FB5FF.1030700@comcast.net>
	<200509080600.39368.ak@suse.de>
	<431FC7DA.6090309@comcast.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> Andi Kleen wrote:
> 
>  >Hmm - not many x86-64 patches in mm1. 2.6.13 definitely works.
>  >  
>  >
>  2.6.13-git7 works. So something in -mm has gone bad (if not x86_64, may 
>  be i386 or arch-independent changes?)
>  It seems it has got something to do with the sys_set_tid_address as 
>  evident from the strace output below.
>  Another thing - If I set LD_ASSUME_KERNEL=2.4 and then run the binary, 
>  it works fine.

I can't reproduce this with the current -mm lineup.  I compiled up a 32-bit
app on x86 and transferred that across.

Maybe it got fixed.  Please test 2.6.13-mm2, which appears to be an hour or
two away.  If it still fails then I'd need a recipe (including URLs and
stuff) with which to reproduce it please.

