Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTFTI6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFTI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:58:12 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:43780 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262489AbTFTI6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:58:07 -0400
Date: Fri, 20 Jun 2003 19:10:50 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
cc: Marcelo Tosatti <marcelo@hera.kernel.org>, <netdev@oss.sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Alan Cox <alan@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.4.21][FIX] use mod_timer
In-Reply-To: <1056091000.1200.23.camel@lima.royalchallenge.com>
Message-ID: <Mutt.LNX.4.44.0306201907450.27218-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2003, Vinay K Nallamothu wrote:

> Hi,
> 
> This patch makes use of mod_timer instead of {del,add}_timer.
> 
> Most of the patches already in -ac series since 2.4.21-rc2 and few of
> the networking fixes in 2.5.69
> 
> The following files are affected:
> 
> arch/ia64/sn/kernel/irq.c
> arch/ia64/sn/kernel/mca.c
> drivers/block/floppy.c
> drivers/net/wan/sdla_chdlc.c
> drivers/net/wan/sdla_fr.c
> drivers/net/wan/sdla_x25.c
> net/core/dst.c
> net/sched/sch_cbq.c
> net/sched/sch_csz.c
> net/sched/sch_htb.c


FYI, the status of the networking patches is:

                     2.5-bk   2.4.21-ac1    2.4-bk
net/core/dst.c        yes        no           no
net/sched/sch_cbq.c   yes       yes           no
net/sched/sch_csz.c   yes       yes           no
net/sched/sch_htb.c   yes       yes           no



- James
-- 
James Morris
<jmorris@intercode.com.au>

