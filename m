Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVCPWML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVCPWML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVCPWMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:12:10 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:39555
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262827AbVCPWJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:09:40 -0500
Date: Wed, 16 Mar 2005 14:07:37 -0800
From: "David S. Miller" <davem@davemloft.net>
To: <shenkel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix unaligned accesses in tcp_input_parse
Message-Id: <20050316140737.7325f9fb.davem@davemloft.net>
In-Reply-To: <16952.4619.28663.456755@gargle.gargle.HOWL>
References: <16952.4619.28663.456755@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 12:01:31 +0100
<shenkel@gmail.com> wrote:

> TCP options are not guaranteed to be aligned at all, so we should use
> get_unaligned when accessing u16- or u32-values in the TCP
> options header to avoid alignment errors on some platforms. The patch
> applies to vanilla 2.6.11.

Applied, thanks.
