Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270813AbTHOStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270808AbTHOStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:49:10 -0400
Received: from dp.samba.org ([66.70.73.150]:21166 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270804AbTHOSrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:47:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ISDN PCBIT: #ifdef MODULE some code 
In-reply-to: Your message of "Mon, 28 Jul 2003 22:25:01 +0200."
             <20030728202500.GM25402@fs.tum.de> 
Date: Sat, 16 Aug 2003 02:51:20 +1000
Message-Id: <20030815184720.B0E502CE86@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030728202500.GM25402@fs.tum.de> you write:
> I got the following error at the final linkage of 2.6.0-test2 if 
> CONFIG_ISDN_DRV_PCBIT is compiled statically:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> ...
> drivers/built-in.o(.exit.text+0xe183): In function `pcbit_exit':
> : undefined reference to `pcbit_terminate'
> make: *** [.tmp_vmlinux1] Error 1

AFAICT This is also broken in 2.4.22-rc2, which makes me wonder if
anyone actually cares about this driver?

Taken anyway, for both.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
