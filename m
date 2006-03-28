Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWC1ASm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWC1ASm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWC1ASm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:18:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932160AbWC1ASl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:18:41 -0500
Date: Mon, 27 Mar 2006 16:20:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [PATCH] MTD: m25p80: fix printk format warning
Message-Id: <20060327162053.5d84ae59.akpm@osdl.org>
In-Reply-To: <20060327161402.06eaa84b.rdunlap@xenotime.net>
References: <20060327161402.06eaa84b.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> Fix printk format warning:
> drivers/mtd/devices/m25p80.c:189: warning: format '%zd' expects type 'signed size_t', but argument 6 has type 'u_int32_t'

Thanks, this is already fixed in one of the oft-sent, oft-ignored MTD
patches in -mm.
