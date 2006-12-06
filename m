Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937622AbWLFU0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937622AbWLFU0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937623AbWLFU0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:26:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37243 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937622AbWLFU0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:26:22 -0500
Date: Wed, 6 Dec 2006 12:26:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/{char|isdn}: work_struct-induced breakage
Message-Id: <20061206122620.c090f7d9.akpm@osdl.org>
In-Reply-To: <200612061959.kB6Jx1s2026778@hera.kernel.org>
References: <200612061959.kB6Jx1s2026778@hera.kernel.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 19:59:01 GMT
Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:

>     [PATCH] drivers/{char|isdn}: work_struct-induced breakage
>     
>     part 1 of fsck-knows-how-many

dammit

> +static void stli_dohangup(struct work_struct *ugly_api)
> +static void do_rc_hangup(struct work_struct *ugly_api)
> +static void do_softint(struct work_struct *ugly_api)
> +do_softint(struct work_struct *ugly_api)
> +ergo_irq_bh(struct work_struct *ugli_api)
> +__adb_probe_task(struct work_struct *bullshit)

I detect a trace of dissatisfaction there.
