Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUCCTns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUCCTn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:43:28 -0500
Received: from ns.suse.de ([195.135.220.2]:21183 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262567AbUCCTnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:43:21 -0500
To: Billy Rose <billyrose@cox-internet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel mode console
References: <200403022152.06950.billyrose@cox-internet.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Mar 2004 18:18:34 +0100
In-Reply-To: <200403022152.06950.billyrose@cox-internet.com.suse.lists.linux.kernel>
Message-ID: <p73fzcp4zo5.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Billy Rose <billyrose@cox-internet.com> writes:

> i have some bandwidth i can dedicate to writting a kernel module that provides 
> a command interpreter running in kernel space (think of it as the god mode 
> console in quake). the purpose for this would be primarily aimed at the 
> kernel developers so they can reach in and grab variables, dump certain 
> sections of memory, walk memory, dump code segments, dump processes 
> (including the kernel data structures for them), anything else i/you can 
> think of. is this a waste of time, or would that get used?

It sounds like you're trying to reinvent kdb, sysrq, kgdb, lcrash/crash,
gdb vmlinux /proc/vmlinux

-Andi
