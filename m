Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUC0AJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUC0AJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:09:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261498AbUC0AJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:09:54 -0500
Date: Fri, 26 Mar 2004 16:08:23 -0800
From: "David S. Miller" <davem@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org,
       wli@holomorphy.com
Subject: Re: Sparc64, cpumask_t and struct arguments (was: [PATCH] Introduce
 nodemask_t ADT)
Message-Id: <20040326160823.224150c8.davem@redhat.com>
In-Reply-To: <20040326152927.5992b011.pj@sgi.com>
References: <20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
	<20040322183918.5e0f17c7.pj@sgi.com>
	<20040323031345.GY2045@holomorphy.com>
	<20040322193628.4278db8c.pj@sgi.com>
	<20040323035921.GZ2045@holomorphy.com>
	<20040325012457.51f708c7.pj@sgi.com>
	<20040325101827.GO791@holomorphy.com>
	<20040326143648.5be0e221.pj@sgi.com>
	<20040326145423.74c1ce52.davem@redhat.com>
	<20040326152927.5992b011.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 15:29:27 -0800
Paul Jackson <pj@sgi.com> wrote:

> > It's a problem moreso on sparc32.
> 
> Ah good.  Then, since arch/sparc and include/asm-sparc make no use
> of cpumask_t, can I therefore conclude that you don't care whether
> it's really a struct, or not?
> 
> That would be good news, if so.

SMP on sparc32 is totally not working yet in 2.6.x, that is why
there are no cpumask_t references :-)
