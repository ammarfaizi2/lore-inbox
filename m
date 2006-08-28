Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932412AbWH1HgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWH1HgE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 28 Aug 2006 03:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWH1HgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 03:36:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932412AbWH1HgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 03:36:01 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Bjoern Steinbrink <B.Steinbrink@gmx.de>,
        Arjan van de Ven <arjan@infradead.org>,
        Chase Venters <chase.venters@clientec.com>,
        Andrew Morton <akpm@osdl.org>,
        Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
References: <20060827214734.252316000@klappe.arndb.de>
	<20060827215637.555365000@klappe.arndb.de>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2006 09:35:17 +0200
In-Reply-To: <20060827215637.555365000@klappe.arndb.de>
Message-ID: <p73ac5pe2iy.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The _syscallX macros were originally used by libc implementations,
> but now there is no libc that can be built against an up-to-date
> kernel an relies on them.
> The only users of these macros are the __KERNEL_SYSCALLS_, which
> are now gone as well, after execve has been removed from the
> kernel.

I would prefer to keep them on i386/x86-64 at least because
a lot of my test programs are using them.

-Andi
