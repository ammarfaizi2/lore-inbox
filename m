Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269645AbUICMY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbUICMY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269663AbUICMVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:21:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:27795 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269645AbUICMRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:17:38 -0400
Subject: Re: [PATCH] 2.6.8.1 ES7000 subarch update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Davis <jason.davis@unisys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040902235214.GA21954@righTThere.net>
References: <20040902235214.GA21954@righTThere.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094210117.7533.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 12:15:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 00:52, Jason Davis wrote:
>  int 			mip_port;
>  unsigned long		mip_addr, host_addr;
>  
> +EXPORT_SYMBOL(mip_reg);
> +EXPORT_SYMBOL(host_reg);
> +EXPORT_SYMBOL(mip_port);
> +EXPORT_SYMBOL(mip_addr);
> +EXPORT_SYMBOL(host_addr);

This is asking for collisions with other modules. It would be a lot
better for the future it these became e7000_mip_reg etc I think.

