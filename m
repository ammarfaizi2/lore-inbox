Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUANTeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUANTa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:30:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:30436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264442AbUANTap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:30:45 -0500
Date: Wed, 14 Jan 2004 11:31:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-Id: <20040114113107.786c237a.akpm@osdl.org>
In-Reply-To: <20040114161306.GA16950@stop.crashing.org>
References: <20040110032915.GW18208@waste.org>
	<20040109193753.3c158b3b.akpm@osdl.org>
	<20040114161306.GA16950@stop.crashing.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
>  As has been previously noted, the cond_syscall is only ever cared about
>  on PPC when you try for !PCI.  And this only happens realistically now,
>  on MPC8xx (it's usually present on IBM 4xx, and lets ignore APUS).
>  MPC8xx support has been broken for a while, but hopefully will get fixed
>  'soon'.
> 
>  So can we please move this cond_syscall into kernel/sys.c ?

Spose so.  Are we sure it shouldn't be inside soem ppc-specfic ifdef?


