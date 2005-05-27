Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVE0Sxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVE0Sxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVE0Sxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:53:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21227 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262532AbVE0Sxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:53:38 -0400
Date: Fri, 27 May 2005 19:53:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, mchan@broadcom.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
Message-ID: <20050527185334.GA7417@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
	mchan@broadcom.com
References: <04132005193844.8410@laptop> <04132005193844.8474@laptop> <20050421165956.55bdcb14.davem@davemloft.net> <20050527184750.GB11592@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527184750.GB11592@tuxdriver.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:47:52PM -0400, John W. Linville wrote:
> Update pci.ids for BCM5752
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> 
>  drivers/pci/pci.ids |    1 +
>  1 files changed, 1 insertion(+)
> 
> --- tg3-pci/drivers/pci/pci.ids.orig	2005-05-27 14:41:25.243607911 -0400
> +++ tg3-pci/drivers/pci/pci.ids	2005-05-27 14:43:45.553326412 -0400
> @@ -7173,6 +7173,7 @@
>  	080f  Sentry5 DDR/SDR RAM Controller
>  	0811  Sentry5 External Interface Core
>  	0816  BCM3302 Sentry5 MIPS32 CPU
> +	1600  NetXtreme BCM5752 Gigabit Ethernet PCI Express

I don't think you should mention "PCI Express" here.  That can trivially
befound it looking at the configuration header.

