Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTJXGjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 02:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTJXGiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 02:38:52 -0400
Received: from dp.samba.org ([66.70.73.150]:6595 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262037AbTJXGir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 02:38:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: tharbaugh@lnxi.com
Cc: linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederman@lnxi.com>
Subject: Re: [BUG][PATCH] BIOS reserved regions block iomem registration 
In-reply-to: Your message of "22 Oct 2003 12:57:43 CST."
             <1066849062.6281.190.camel@tubarao> 
Date: Fri, 24 Oct 2003 14:21:36 +1000
Message-Id: <20031024063847.4CF072C0FA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1066849062.6281.190.camel@tubarao> you write:
> arch/i386/kernel/setup.c:register_memory() marks e820 memory regions -
> some of which are "reserved".  These "reserved" regions prevent FLASH
> chip drivers from registering the memory range occupied by BIOS code:

Not trivial, sorry.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
