Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVARUms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVARUms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVARUms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:42:48 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:23973
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261409AbVARUmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:42:42 -0500
Date: Tue, 18 Jan 2005 12:38:09 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport xfrm_policy_delete
Message-Id: <20050118123809.3a051164.davem@davemloft.net>
In-Reply-To: <20050118102932.GD4274@stusta.de>
References: <20050118102932.GD4274@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 11:29:32 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> I haven't found any way how xfrm_policy_delete could be called from 
> modular code in 2.6.11-rc1-mm1.
> 
> Unless I'm wrong or a patch for a modular usage is pending, I'm 
> therefore suggesting this patch for removing the EXPORT_SYMBOL.

Looks good to me, applied.

Thanks Adrian.
