Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUGBX3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUGBX3g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUGBX3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:29:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:64976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265100AbUGBX3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:29:35 -0400
Date: Fri, 2 Jul 2004 16:32:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] add TRAP_BAD_SYSCALL_EXITS config for i386
Message-Id: <20040702163219.7ec698e2.akpm@osdl.org>
In-Reply-To: <200407021628.i62GS7ZS002412@voidhawk.shadowen.org>
References: <200407021628.i62GS7ZS002412@voidhawk.shadowen.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> There seems to be code recently added to -bk and thereby -mm which supports
> extra debug for preempt on system call exit.  Oddly there doesn't seem
> to be configuration options to enable them.  Below is a possible patch
> to allow enabling this on i386.  Sadly the most obvious menu to add this
> to is the Kernel Hacking menu, but that is defined in architecture specific
> configuration.  If this makes sense I could patch the other arches?

The TRAP_BAD_SYSCALL stuff is actually a bloa^Wfeature which was added
via the kgdb patch, so it is not in -bk.

I've never used it, dunno what it does.  I'll roll your two patches into the
kgdb patches in -mm, thanks.
