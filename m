Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbTLISeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTLISeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:34:21 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:4293 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S266096AbTLISeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:34:17 -0500
Date: Tue, 9 Dec 2003 19:34:12 +0100
From: Kristian Peters <kristian.peters@korseby.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Peter Bergmann <bergmann.peter@gmx.net>, <linux-kernel@vger.kernel.org>,
       <nfedera@esesix.at>, <andrea@suse.de>, <riel@redhat.com>
Subject: Re: Configurable OOM killer Re: old oom-vm for 2.4.32 (was oom
 killer  in 2.4.23)
Message-Id: <20031209193412.39c1ca71.kristian.peters@korseby.net>
In-Reply-To: <10xwC-2O0-7@gated-at.bofh.it>
References: <Zxp0-1lf-9@gated-at.bofh.it>
	<10xwC-2O0-7@gated-at.bofh.it>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686 Linux 2.4.23-ck1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> schrieb:
> The following patch makes OOM killer configurable (its the same as the 
> other patches posted except its around CONFIG_OOM_KILLER).
> 
> I hope the Configure.help entry is clear enough.

What about the PF_MEMDIE issues Andrea has argued ? Are they solved by the added code in page_alloc.c ?

As Andrea has pointed out earlier, a yield() after out_of_memory() is safe and should be added too.

I'd really like to see that config-option in 2.4.24.

*Kristian
