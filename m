Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUIJF1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUIJF1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUIJF1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:27:06 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:37004
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268126AbUIJF1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:27:02 -0400
Date: Thu, 9 Sep 2004 22:26:21 -0700
From: "David S. Miller" <davem@davemloft.net>
To: kaigai@ak.jp.nec.com (Kaigai Kohei)
Cc: akpm@osdl.org, hugh@veritas.com, ecd@skynet.be, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, takata.hirokazu@renesas.com,
       kaigai@ak.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_inc_return() for sparc64[5/5] (Re:
 atomic_inc_return)
Message-Id: <20040909222621.3194f219.davem@davemloft.net>
In-Reply-To: <200409100332.i8A3W6YV007141@mailsv.bs1.fc.nec.co.jp>
References: <Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
	<200409100332.i8A3W6YV007141@mailsv.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 12:32:06 +0900 (JST)
kaigai@ak.jp.nec.com (Kaigai Kohei) wrote:

> 
> [5/5] atomic_inc_return-linux-2.6.9-rc1.sparc64.patch
>   This patch declares atomic_add_return() as an alias of __atomic_add().
>   atomic64_add_return(),atomic_sub_return() and atomic64_sub_return() are same.
>   This patch has not been tested, since we don't have SPARC64 machine.  
>   I want to let this reviewed by SPARC64 specialists.
> 
> Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>

This looks fine to me.
