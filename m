Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752149AbWCEHVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbWCEHVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbWCEHVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:21:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752139AbWCEHVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:21:24 -0500
Date: Sat, 4 Mar 2006 23:19:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/8] [I/OAT] Structure changes for TCP recv offload to
 I/OAT
Message-Id: <20060304231951.0e83e23b.akpm@osdl.org>
In-Reply-To: <20060303214229.11908.19898.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214229.11908.19898.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> +#ifdef CONFIG_NET_DMA
>  +#include <linux/dmaengine.h>
>  +#endif

Please move the ifdefs into the header and include it unconditionally
(entire patchset).

