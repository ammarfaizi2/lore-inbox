Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUAGG3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUAGG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:29:11 -0500
Received: from ns.suse.de ([195.135.220.2]:60292 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265051AbUAGG3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:29:09 -0500
Date: Wed, 7 Jan 2004 07:29:06 +0100
From: Andi Kleen <ak@suse.de>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more fixes for Opteron ia32 siginfo interface
Message-Id: <20040107072906.24b97bfe.ak@suse.de>
In-Reply-To: <20040106162818.GA9430@rudolph.ccur.com>
References: <20040106162818.GA9430@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004 11:28:18 -0500
Joe Korty <joe.korty@ccur.com> wrote:

> Andi and Andrew,
> 
> This patch should fix all the remaining Opteron ia32 siginfo_t issues
> in 2.6.0.  It has been only lightly tested: posix timer tests, a small
> sigqueue(2) test that I wrote, and part of ltp, all compiled in ia32
> mode.

I applied the patch. Some hunks in ia32_signal.c rejected, but I merged
them by hand (and fixed the indentation in the comments) 

Thanks,

-Andi

