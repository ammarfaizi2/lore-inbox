Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVBKVQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVBKVQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVBKVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:16:15 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:30853
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262343AbVBKVPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:15:10 -0500
Date: Fri, 11 Feb 2005 13:13:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Michael Chan" <mchan@broadcom.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH] tg3: capacitive coupling detection fix
Message-Id: <20050211131355.5e084004.davem@davemloft.net>
In-Reply-To: <B1508D50A0692F42B217C22C02D84972020F3D93@NT-IRVA-0741.brcm.ad.broadcom.com>
References: <B1508D50A0692F42B217C22C02D84972020F3D93@NT-IRVA-0741.brcm.ad.broadcom.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005 12:44:10 -0800
"Michael Chan" <mchan@broadcom.com> wrote:

> This patch fixes the problem reported in:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110798711911645&w=2
> 
> The 5700 link problem was caused by reading uninitialized values in sram and
> causing capacitive coupling mode to be enabled by mistake. This patch fixes
> the problem by properly validating the sram contents.
> 
> Signed-off-by: Michael Chan <mchan@broadcom.com>

Applied, thanks a lot Michael.
