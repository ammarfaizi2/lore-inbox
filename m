Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272625AbTG1Blp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272231AbTG1BkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 21:40:10 -0400
Received: from rth.ninka.net ([216.101.162.244]:34179 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S272315AbTG1Bj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:39:57 -0400
Date: Sun, 27 Jul 2003 18:55:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: florin@iucha.net (Florin Iucha)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] Fix ipt_helper compilation. Was: Linux
 v2.6.0-test2
Message-Id: <20030727185508.35307c31.davem@redhat.com>
In-Reply-To: <20030727202234.GA7280@iucha.net>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
	<20030727202234.GA7280@iucha.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 15:22:34 -0500
florin@iucha.net (Florin Iucha) wrote:

> One of these broke the compilation of net/ipv4/netfilter/ipt_helper.o:
>   CC [M]  net/ipv4/netfilter/ipt_helper.o
> In file included from net/ipv4/netfilter/ipt_helper.c:13:
> include/linux/netfilter_ipv4/ip_conntrack_core.h: In function `ip_conntrack_confirm':
> include/linux/netfilter_ipv4/ip_conntrack_core.h:46: error: `NF_ACCEPT' undeclared (first use in this function)
> include/linux/netfilter_ipv4/ip_conntrack_core.h:46: error: (Each undeclared identifier is reported only once
> include/linux/netfilter_ipv4/ip_conntrack_core.h:46: error: for each function it appears in.)
> 
> This trivial patch fixes it:

Please post this to the networking and netfilter lists
so that people who work in this area of the kernel will
see your posting.

Thank you.
