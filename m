Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUGFU7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUGFU7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUGFU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:59:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14534 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264492AbUGFU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:58:42 -0400
Date: Tue, 6 Jul 2004 13:55:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH 2.6] ip6t_LOG and packets with hop-by-hop options
Message-Id: <20040706135519.028b22b5.davem@redhat.com>
In-Reply-To: <20040706160109.GO32707@sunbeam2>
References: <20040706150918.GA5009@penguin.localdomain>
	<20040706160109.GO32707@sunbeam2>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 18:01:09 +0200
Harald Welte <laforge@netfilter.org> wrote:

> On Tue, Jul 06, 2004 at 05:09:18PM +0200, Marcel Sebek wrote:
> > Packet with IPPROTO_HOPOPTS extended header isn't logged properly by
> > ip6t_LOG.c. It only prints PROTO=0 and nothing more, because
> > IPPROTO_HOPOPTS=0 and in this file 0 is used to indicate last header.
> > This patch fix it by using IPPROTO_NONE to indicate last header.
> 
> looks fine to me.  Dave, can you please include this to your tree?
> Thanks.

Applied, thanks everyone.
