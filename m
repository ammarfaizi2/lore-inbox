Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUHQWIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUHQWIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUHQWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:08:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:47260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266810AbUHQWI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:08:29 -0400
Date: Tue, 17 Aug 2004 15:12:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq deprecation
Message-Id: <20040817151204.28ecb1a0.akpm@osdl.org>
In-Reply-To: <20040817105859.GA1497@elf.ucw.cz>
References: <20040817105859.GA1497@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Today I learned that /proc/cpufreq is going to be removed 
> from 2.6.. I thought that 2.6 means "no interface changes" :-(.

Well, we'll see.  One very good reason for adding such a runtime warning is
to give people six months to convince the developers that it's a bad idea.

> Anyway, if
> we are going to warn about it, we might want to include newline...

Sure.

> -		printk(KERN_INFO "Access to /proc/sys/cpu/ is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01");
> +		printk(KERN_INFO "Access to /proc/sys/cpu/ is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01\n");

hrmpf.  The original author is hereby impaled upon a metaphorical 80-col
xterm.  Shall fix that too.

