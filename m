Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTIHCIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTIHCIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:08:15 -0400
Received: from dp.samba.org ([66.70.73.150]:63143 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261853AbTIHCIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:08:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, robert@schwebel.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection 
In-reply-to: Your message of "Sun, 07 Sep 2003 13:28:13 +0200."
             <20030907112813.GQ14436@fs.tum.de> 
Date: Mon, 08 Sep 2003 10:46:30 +1000
Message-Id: <20030908020812.3A48F2C186@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030907112813.GQ14436@fs.tum.de> you write:
> - @Rusty:
>   what's your opinion on making MODULE_PROC_FAMILY in 
>   include/asm-i386/module.h some kind of bitmask?

The current one is readable, which is good, and Linus asked for it,
which makes it kinda moot.  And really, if you compile a module with
M686 and insert it in a kernel with M586, *WHATEVER* scheme you we use
for CPU seleciton, I want the poor user to have to use "modprobe -f".

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
