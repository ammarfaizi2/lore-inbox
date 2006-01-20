Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWATJtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWATJtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWATJtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:49:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59876
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750770AbWATJtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:49:05 -0500
Date: Fri, 20 Jan 2006 01:43:26 -0800 (PST)
Message-Id: <20060120.014326.99470463.davem@davemloft.net>
To: mikpe@csd.uu.se
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17360.44337.425946.347577@alkaid.it.uu.se>
References: <20060120004512.GT4603@sunbeam.de.gnumonks.org>
	<20060119.165635.104653932.davem@davemloft.net>
	<17360.44337.425946.347577@alkaid.it.uu.se>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@csd.uu.se>
Date: Fri, 20 Jan 2006 10:28:17 +0100

> ACK. Both Harald's patch and DaveM's simplification of it
> (simply s/void */u_int64_t/g in XT_ALIGN()) fix the iptables
> problems on my ppc32 box.

Thanks for testing.
