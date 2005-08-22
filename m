Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVHVT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVHVT7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVHVT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:59:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:51162 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750914AbVHVT7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:59:52 -0400
Date: Mon, 22 Aug 2005 10:30:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, chrisw@osdl.org,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SECURITY must depend on SYSFS
Message-ID: <20050822173003.GS7762@shell0.pdx.osdl.net>
References: <20050822162050.GC9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822162050.GC9927@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
>  config SECURITY
>  	bool "Enable different security models"
> +	depends on SYSFS

Hmm, what about select instead?

thanks,
-chris
