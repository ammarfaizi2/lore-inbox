Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVECAdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVECAdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVECAdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:33:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:34976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVECAds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:33:48 -0400
Date: Mon, 2 May 2005 17:30:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@muc.de, hch@lst.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been
 removed last month
Message-Id: <20050502173052.5c78ae30.akpm@osdl.org>
In-Reply-To: <20050502014550.GG3592@stusta.de>
References: <20050502014550.GG3592@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This removal should have happened last month.

drivers/usb/misc/sisusbvga/sisusb.c will use these functions if someone
defines SISUSB_OLD_CONFIG_COMPAT, so we need to agree to zap that code
before I can merge this upstream.
