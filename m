Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUHPCt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUHPCt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267366AbUHPCt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:49:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267363AbUHPCtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:49:16 -0400
Date: Sun, 15 Aug 2004 19:45:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: Patrick McHardy <kaber@trash.net>
Cc: lkml@lazy.shacknet.nu, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [Panic] 2.6.8 and ingress scheduling
Message-Id: <20040815194555.1990f313.davem@redhat.com>
In-Reply-To: <411F8B50.2020402@trash.net>
References: <20040814175233.GA3617@lazy.shacknet.nu>
	<20040815130635.GA3703@lazy.shacknet.nu>
	<411F8B50.2020402@trash.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 18:12:00 +0200
Patrick McHardy <kaber@trash.net> wrote:

> Fixed by this patch. qdisc_data was only aligned correctly in 
> qdisc_create_dflt(),
> not qdisc_create() which resulted in memory corruption.

Oops, thanks Patrick.  Patch applied.
