Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVCRSkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVCRSkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCRSkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:40:46 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:13013
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261662AbVCRSkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:40:43 -0500
Date: Fri, 18 Mar 2005 10:37:22 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Sven Henkel <shenkel@gmail.com>
Cc: maxk@qualcomm.com, vtun@office.satix.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix alignment in tun_get_user
Message-Id: <20050318103722.4cda967d.davem@davemloft.net>
In-Reply-To: <16955.7466.627773.654710@gargle.gargle.HOWL>
References: <16955.7466.627773.654710@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 19:25:46 +0100
Sven Henkel <shenkel@gmail.com> wrote:

> This patch fixes an alignment-problem in tun_get_user: Only
> ethernet-frames need to be headed by 2 bytes (due to their size of 14
> bytes), IP-frames should not be touched. The patch changes
> tun_get_user to reserve 2 bytes of the skb for TUN_TAP_DEVs and 0
> bytes otherwise.

Applied, thanks Sven.

My comments wrt. posting patches to netdev@oss.sgi.com still
apply :-)
