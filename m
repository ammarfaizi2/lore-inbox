Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031716AbWLAB2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031716AbWLAB2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031719AbWLAB2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:28:07 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:14993
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031717AbWLAB2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:28:04 -0500
Date: Thu, 30 Nov 2006 17:28:06 -0800 (PST)
Message-Id: <20061130.172806.125565481.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] net/: possible cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061124215820.GI28363@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
	<20061124215820.GI28363@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 24 Nov 2006 22:58:20 +0100

> This patch contains the following possible cleanups:
> - make the following needlessly global functions statis:
>   - ipv4/tcp.c: __tcp_alloc_md5sig_pool()
>   - ipv4/tcp_ipv4.c: tcp_v4_reqsk_md5_lookup()
>   - ipv4/udplite.c: udplite_rcv()
>   - ipv4/udplite.c: udplite_err()
> - make the following needlessly global structs static:
>   - ipv4/tcp_ipv4.c: tcp_request_sock_ipv4_ops
>   - ipv4/tcp_ipv4.c: tcp_sock_ipv4_specific
>   - ipv6/tcp_ipv6.c: tcp_request_sock_ipv6_ops
> - net/ipv{4,6}/udplite.c: remove inline's from static functions
>                           (gcc should know best when to inline them)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
