Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269378AbUICItZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269378AbUICItZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269288AbUICIry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:47:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:29701 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269393AbUICI3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:29:07 -0400
Date: Fri, 3 Sep 2004 09:28:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jason Davis <jason.davis@unisys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.8.1 ES7000 subarch update
Message-ID: <20040903092850.C2288@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jason Davis <jason.davis@unisys.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20040902235214.GA21954@righTThere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040902235214.GA21954@righTThere.net>; from jason.davis@unisys.com on Thu, Sep 02, 2004 at 07:52:14PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +EXPORT_SYMBOL(mip_reg);
> +EXPORT_SYMBOL(host_reg);
> +EXPORT_SYMBOL(mip_port);
> +EXPORT_SYMBOL(mip_addr);
> +EXPORT_SYMBOL(host_addr);

There's no modular user of these anywhere in sight. 

> +	else if (cycle_irqs ^ free_irqs)
> +	{

wrong indentation.

