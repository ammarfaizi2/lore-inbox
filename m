Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268103AbTGIKM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbTGIKLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:11:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268115AbTGIKH1 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:07:27 -0400
Date: Wed, 9 Jul 2003 03:22:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
Message-Id: <20030709032227.23ee4159.akpm@osdl.org>
In-Reply-To: <16139.54887.932511.717315@laputa.namesys.com>
References: <16139.54887.932511.717315@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
>  +	if (priority < 0) {
>  +		for (i = 0; i < pgdat->nr_zones; i++) {
>  +			struct zone *zone = pgdat->node_zones + i;
>  +
>  +			if (zone->free_pages < zone->pages_high)
>  +				zone_adj_pressure(zone, -1);
>  +		}
>  +	}

What is this bit doing?
