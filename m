Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWFKTnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWFKTnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFKTnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:43:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38125 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750874AbWFKTnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:43:15 -0400
Date: Sun, 11 Jun 2006 21:42:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
In-Reply-To: <200606111512_MC3-1-C229-37D@compuserve.com>
Message-ID: <Pine.LNX.4.61.0606112141440.9782@yvahk01.tjqt.qr>
References: <200606111512_MC3-1-C229-37D@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Using C code for current_thread_info() lets the compiler optimize it.
>With gcc 4.0.2, kernel is smaller:
>
>    text           data     bss     dec     hex filename
> 3645212         555556  312024 4512792  44dc18 2.6.17-rc6-nb-post/vmlinux
> 3647276         555556  312024 4514856  44e428 2.6.17-rc6-nb/vmlinux
> -------
>   -2064
>

If possible, can you or someone post the results for x86_64?



Jan Engelhardt
-- 
