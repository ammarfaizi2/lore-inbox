Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVLRRV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVLRRV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVLRRV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:21:29 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:32208 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965228AbVLRRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:21:29 -0500
Date: Sun, 18 Dec 2005 12:21:11 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
In-Reply-To: <43A5A7B5.21A4CAAE@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0512181220420.21304@gandalf.stny.rr.com>
References: <43A5A7B5.21A4CAAE@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Dec 2005, Oleg Nesterov wrote:

> Rediff against patch-2.6.15-rc5-rt2.
>
> Nothing was changed except s/plist_next_entry/plist_first_entry/
> to match the current naming.
>
> These patches were only compile tested. This is beacuse I can't
> even compile 2.6.15-rc5-rt2, I had to comment out this line
>
> 	lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
>
> in lib/Makefile. I think CONFIG_RWSEM_GENERIC_SPINLOCK means that
> lib/rwsem.c should be ignored.
>

I've already submitted patches to Ingo to fix this.

-- Steve

