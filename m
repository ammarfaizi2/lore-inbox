Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVCRSdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVCRSdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVCRSdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:33:08 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:62433
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262018AbVCRSc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:32:57 -0500
Date: Fri, 18 Mar 2005 10:32:49 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Sven Henkel <shenkel@gmail.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Align udp-packet in netpoll_send_udp
Message-Id: <20050318103249.7d1ec399.davem@davemloft.net>
In-Reply-To: <16955.5772.749812.983639@gargle.gargle.HOWL>
References: <16955.5772.749812.983639@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 18:57:32 +0100
Sven Henkel <shenkel@gmail.com> wrote:

> The udp-packet constructed in netpoll_send_udp should be aligned
> to avoid alignment-traps on some platforms. The patch applies to
> vanilla 2.6.11.2.

Patch applied, thanks Sven.

Please post networking patches in the future to netdev@oss.sgi.com,
as that is where the networking developers are.

Thanks.
