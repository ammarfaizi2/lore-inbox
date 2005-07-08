Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVGHXvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVGHXvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVGHXvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:51:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262802AbVGHXvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:51:21 -0400
Date: Fri, 8 Jul 2005 16:52:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for slab leak debugging
Message-Id: <20050708165212.2e16decc.akpm@osdl.org>
In-Reply-To: <1120856219.25294.29.camel@localhost.localdomain>
References: <1120856219.25294.29.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> +config SLAB_OWNER
> +	bool "Track owner of slab objects"
> +	depends on DEBUG_KERNEL && DEBUG_SLAB

I guess this should select CONFIG_KALLSYMS
