Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272258AbTHDUmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272277AbTHDUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:42:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:52152 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272274AbTHDUmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:42:20 -0400
Date: Mon, 4 Aug 2003 13:43:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: swsusp updates
Message-Id: <20030804134338.5d0f65cd.akpm@osdl.org>
In-Reply-To: <20030804201432.GA467@elf.ucw.cz>
References: <20030804201432.GA467@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Here are swsusp updates, retransmitted. Please apply this time.

With CONFIG_SOFTWARE_SUSPEND=n:

kernel/suspend.c: In function `prepare_suspend_console':
kernel/suspend.c:272: `orig_loglevel' undeclared (first use in this function)
kernel/suspend.c:272: (Each undeclared identifier is reported only once
kernel/suspend.c:272: for each function it appears in.)
kernel/suspend.c:273: `new_loglevel' undeclared (first use in this function)
kernel/suspend.c:276: `orig_fgconsole' undeclared (first use in this function)
kernel/suspend.c: In function `restore_console':
kernel/suspend.c:297: `orig_loglevel' undeclared (first use in this function)

