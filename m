Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUBLVmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUBLVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:42:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:20163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266610AbUBLVl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:41:59 -0500
Date: Thu, 12 Feb 2004 13:43:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] bogus __KERNEL_SYSCALLS__ usage
Message-Id: <20040212134342.0874290a.akpm@osdl.org>
In-Reply-To: <20040212162856.GU12634@redhat.com>
References: <20040212162856.GU12634@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> I just did a mini-audit of users of __KERNEL_SYSCALLS and turned
> up a bunch of uglies. The patch below is the easy ones

OK.  But Randy is currently beavering away at the astonishing number of
open-coded sys_foo() declarations, and that work has a significant
intersection with yours.

So can we please park this for now, pick it up again when Randy has
finished?

