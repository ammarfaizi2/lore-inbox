Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUFWPBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUFWPBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFWPBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:01:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266142AbUFWPBL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:01:11 -0400
Date: Wed, 23 Jun 2004 08:00:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.7-bk6 fails module compile -- iptable_raw.c
Message-Id: <20040623080027.09457b66.davem@redhat.com>
In-Reply-To: <20040623.224203.122414746.yoshfuji@linux-ipv6.org>
References: <200406231256.IAA28505@clem.clem-digital.net>
	<20040623.224203.122414746.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 22:42:03 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> > net/ipv4/netfilter/iptable_raw.c:57: unknown field `target_size' specified in initializer
 ...
> Please try this.
> 
> ===== net/ipv4/netfilter/iptable_raw.c 1.2 vs edited =====
> --- 1.2/net/ipv4/netfilter/iptable_raw.c	2004-06-22 06:39:19 +09:00
> +++ edited/net/ipv4/netfilter/iptable_raw.c	2004-06-23 22:35:44 +09:00

Applied, thanks.
