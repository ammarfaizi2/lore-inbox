Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWJLT7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWJLT7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWJLT7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:59:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750834AbWJLT7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:59:17 -0400
Date: Thu, 12 Oct 2006 12:59:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Doug Reiland" <dreiland@gmail.com>
Cc: "Frank Sorenson" <frank@tuxrocks.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.6.19-rc1
Message-Id: <20061012125912.8a447ed2.akpm@osdl.org>
In-Reply-To: <6844644e0610121250m5310a038w9000093b8d149ba2@mail.gmail.com>
References: <452D43B6.8020406@tuxrocks.com>
	<20061012000643.f875c96e.akpm@osdl.org>
	<452E93D7.6020004@tuxrocks.com>
	<6844644e0610121250m5310a038w9000093b8d149ba2@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 15:50:24 -0400
"Doug Reiland" <dreiland@gmail.com> wrote:

> FYI, I had to get CONFIG_SYSCTL_SYSCALL set to solve my 2.6.19-rc1 boot
> panic.

What boot panic was that?

> Actually, I couldn't get CONFIG_SYSCTL_SYSCALL=y to stick so I modified
> kernel/sysctl.c's ifdefs.

It depends on CONFIG_EMBEDDED.
