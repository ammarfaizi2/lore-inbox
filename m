Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUIGPrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUIGPrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUIGPnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:43:05 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:11453
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268314AbUIGPkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:40:06 -0400
Date: Tue, 7 Sep 2004 08:37:23 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Ludo Stellingwerff <ludo@protactive.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sporadic hitting the BUG() in the XFRM Garbage Collector
Message-Id: <20040907083723.5138c770.davem@davemloft.net>
In-Reply-To: <413DD17E.3050804@protactive.nl>
References: <413DD17E.3050804@protactive.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2004 17:19:26 +0200
Ludo Stellingwerff <ludo@protactive.nl> wrote:

> This seems to happen at the removal of a IPsec policy. Some data: kernel 
> 2.6.6. with Netfilter POM IPSEC-patches, ipsec-tools 0.2.3.

Known problem with xfrm reference counting, fixed in 2.6.7
and later.

Please report networking bugs to the proper channels in
the future, namely linux-net@vger.kernel.org and netdev@oss.sgi.com
as this is where the networking developers listen.

Thanks.
