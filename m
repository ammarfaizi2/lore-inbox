Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUCLBWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUCLBWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:22:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:15825 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261884AbUCLBWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:22:39 -0500
Date: Thu, 11 Mar 2004 17:22:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311172244.3ae0587f.akpm@osdl.org>
In-Reply-To: <16465.3163.999977.302378@notabene.cse.unsw.edu.au>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> 
> 2.6.4-mm1 doesn't work for me :-(
> 
> I get the:
>    Uncompressing kernel ... now booting Linux
> 
> message, and then ...... nothing.
> 
> I've seen this before when trying to boot a P4 kernel on a P-classic
> etc, so I tried compiling with CONFIG_M386, and got lots of compile
> errors:
> 
> include/asm/acpi.h: In function `__acpi_acquire_global_lock':
> include/asm/acpi.h:74: warning: implicit declaration of function `cmpxchg'
> 
> So I tried the default (CONFIG_M686) and it still doesn't work.
> 
> So: where do I look next?
> 
> I've included some of the machine specs below together with a config
> file.

Tried adding earlyprintk=vga?

If that works, judicious addition of printks will narrow it down.
