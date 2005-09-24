Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVIXXwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVIXXwm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 19:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVIXXwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 19:52:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13538
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750785AbVIXXwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 19:52:41 -0400
Date: Sat, 24 Sep 2005 16:52:18 -0700 (PDT)
Message-Id: <20050924.165218.131424970.davem@davemloft.net>
To: laforge@netfilter.org
Cc: kaber@trash.net, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix NFQUEUE Kconfig dependency
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050923150631.GH731@sunbeam.de.gnumonks.org>
References: <20050923014412.26695cc4.akpm@osdl.org>
	<433412A6.2090904@trash.net>
	<20050923150631.GH731@sunbeam.de.gnumonks.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@netfilter.org>
Date: Fri, 23 Sep 2005 17:06:31 +0200

> [NETFILTER]: Fix ip[6]t_NFQUEUE Kconfig dependency
> 
> We have to introduce a separate Kconfig menu entry for the NFQUEUE targets.
> They cannot "just" depend on nfnetlink_queue, since nfnetlink_queue could
> be linked into the kernel, whereas iptables can be a module.
> 
> Signed-off-by: Harald Welte <laforge@netfilter.org>

Applied, thanks Harald.
