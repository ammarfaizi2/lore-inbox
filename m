Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVEPDTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVEPDTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 23:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEPDTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 23:19:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63385 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261258AbVEPDTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 23:19:04 -0400
Message-ID: <42881122.9070005@pobox.com>
Date: Sun, 15 May 2005 23:18:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Benc <jbenc@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Typo in tulip driver
References: <20050427124856.3abe369f@griffin.suse.cz>
In-Reply-To: <20050427124856.3abe369f@griffin.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Benc wrote:
> This patch fixes a typo in tulip driver in 2.6.12-rc3.
> 
> 
> --- linux-2.6.12-rc3/drivers/net/tulip/tulip_core.c
> +++ linux-2.6.12-rc3-patched/drivers/net/tulip/tulip_core.c
> @@ -1104,7 +1109,7 @@ static void set_rx_mode(struct net_devic
>  			if (entry != 0) {
>  				/* Avoid a chip errata by prefixing a dummy entry. Don't do
>  				   this on the ULI526X as it triggers a different problem */
> -				if (!(tp->chip_id == ULI526X && (tp->revision = 0x40 || tp->revision == 0x50))) {
> +				if (!(tp->chip_id == ULI526X && (tp->revision == 0x40 || tp->revision == 0x50))) {


applied

