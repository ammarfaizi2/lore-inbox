Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270600AbUJUFdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270600AbUJUFdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270594AbUJUF3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:29:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:15261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269137AbUJUF21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:28:27 -0400
Date: Wed, 20 Oct 2004 22:26:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for MODULE_PARM obsolete
Message-Id: <20041020222633.7ec19a4e.akpm@osdl.org>
In-Reply-To: <1098336290.10571.341.camel@localhost.localdomain>
References: <1098336290.10571.341.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> There is no __attribute_unused__: use __attribute__((__unused__)).

Will that fix this?

/usr/src/25/drivers/acpi/tables/tbxfroot.c:168: undefined reference to `MODULE_PARM_'
drivers/built-in.o(.data+0x35dcc):/usr/src/25/drivers/acpi/tables/tbxfroot.c:168: undefined reference to `MODULE_PARM_'
drivers/built-in.o(.data+0x35dd0):/usr/src/25/drivers/acpi/tables/tbxfroot.c:168: undefined reference to `MODULE_PARM_'
drivers/built-in.o(.data+0x35dd4):/usr/src/25/drivers/acpi/tables/tbxfroot.c:168: undefined reference to `MODULE_PARM_'
make: *** [.tmp_vmlinux1] Error 1

