Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUKOXhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUKOXhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKOXf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:35:29 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:38622
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261645AbUKOXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:32:37 -0500
Date: Mon, 15 Nov 2004 15:17:32 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [patch] 2.4.28-rc3: neigh_for_each must be EXPORT_SYMBOL'ed
Message-Id: <20041115151732.4f26c139.davem@davemloft.net>
In-Reply-To: <4198CAFC.7030705@ttnet.net.tr>
References: <4198CAFC.7030705@ttnet.net.tr>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004 17:27:56 +0200
"O.Sezer" <sezeroz@ttnet.net.tr> wrote:

> A similar export should also be needed for __neigh_for_each_release :
> 
> /sbin/depmod -ae -F System.map 2.4.28-rc3aac2
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.28-rc3aac2/kernel/net/atm/clip.o
> depmod: 	__neigh_for_each_release

Good catch, I've fixed this in my tree and will push
upstream.
