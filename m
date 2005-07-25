Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVGYTpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVGYTpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGYToA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:44:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61861
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261472AbVGYTml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:42:41 -0400
Date: Mon, 25 Jul 2005 12:42:57 -0700 (PDT)
Message-Id: <20050725.124257.109907504.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv4/: possible cleanups
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050723220530.GO3160@stusta.de>
References: <20050723220530.GO3160@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 24 Jul 2005 00:05:30 +0200

> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global function:
>   - xfrm4_state.c: xfrm4_state_fini
> - remove the following unneeded EXPORT_SYMBOL's:
>   - ip_output.c: ip_finish_output
>   - ip_output.c: sysctl_ip_default_ttl
>   - fib_frontend.c: ip_dev_find
>   - inetpeer.c: inet_peer_idlock
>   - ip_options.c: ip_options_compile
>   - ip_options.c: ip_options_undo
>   - net/core/request_sock.c: sysctl_max_syn_backlog
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Queued up to my net-2.6.14 tree, thanks Adrian.
