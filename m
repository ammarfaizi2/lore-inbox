Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUHVFZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUHVFZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUHVFZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:25:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266187AbUHVFZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:25:40 -0400
Date: Sat, 21 Aug 2004 22:25:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-kernel@vger.kernel.org, master@sectorb.msk.ru, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
 to become free. Usage count = 1
Message-Id: <20040821222503.51268490.davem@redhat.com>
In-Reply-To: <41280163.1050508@vgertech.com>
References: <411BC284.6080807@vgertech.com>
	<20040813080334.GA13337@tentacle.sectorb.msk.ru>
	<411D2625.2070908@vgertech.com>
	<41280163.1050508@vgertech.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 03:13:55 +0100
Nuno Silva <nuno.silva@vgertech.com> wrote:

> This problem was introduced between 2.6.8-rc2-bk11 and 2.6.8-rc4-bk1 and 
> always happens. Right now I'm testing with 2.6.8.1 with a patch from Mr. 
> Miller -- "cacheline-align qdisc data in qdisc_create()" (attached).

Does that patch fix the problem?
