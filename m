Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752263AbWCPIjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbWCPIjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbWCPIjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:39:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60319
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752261AbWCPIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:39:23 -0500
Date: Thu, 16 Mar 2006 00:38:19 -0800 (PST)
Message-Id: <20060316.003819.74819074.davem@davemloft.net>
To: adobriyan@gmail.com
Cc: eugene.teo@eugeneteo.net, linux-kernel@vger.kernel.org,
       thomas@x-berg.in-berlin.de, ralf@linux-mips.org, hans@esrac.ele.tue.nl
Subject: Re: [PATCH] Hamradio: Fix a NULL pointer dereference in
 net/hamradio/mkiss.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060316082413.GA7789@mipter.zuzino.mipt.ru>
References: <20060316064211.GA22681@eugeneteo.net>
	<20060316070737.GA22920@eugeneteo.net>
	<20060316082413.GA7789@mipter.zuzino.mipt.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Thu, 16 Mar 2006 11:24:13 +0300

> Actual codepath, please... valid "ax" is plonked into ->disc_data in
> mkiss_open().

Please be more clear about what you are advocating.
I had to sit and think about what you were saying
before I could figure out that you were actually
suggesting that the NULL check need not be there to
begin with.

Thanks.
