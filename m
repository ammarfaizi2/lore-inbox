Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSLSPUH>; Thu, 19 Dec 2002 10:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLSPUH>; Thu, 19 Dec 2002 10:20:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43217 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265012AbSLSPUG>; Thu, 19 Dec 2002 10:20:06 -0500
Date: Thu, 19 Dec 2002 07:24:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alex Tomas <bzzz@tmi.comex.ru>, William Lee Irwin III <wli@holomorphy.com>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       David Lang <david.lang@digitalinsight.com>, Robert Love <rml@tech9.net>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Message-ID: <14620000.1040311472@titus>
In-Reply-To: <m3u1hapa51.fsf@lexa.home.net>
References: <1040262178.855.106.camel@phantasy>
 <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com>
 <20021219020552.GO31800@holomorphy.com>
 <200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua>
 <20021219102720.GT31800@holomorphy.com> <m3u1hapa51.fsf@lexa.home.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  WLI> As userspace solutions go your suggestions is just as good. The
>  WLI> kernel still needs to get its act together and with some
>  WLI> urgency.
>
> what about retreiving info from /proc/kmem or something like? just to
> avoid binary -> text(proc) -> binary

The binary <-> text translation problem is less of an issue than all the
syscall traffic, dcache hits, etc. Search linux-kernel archives for a
recent thread entitiled "ps performance sucks" or something similar.

M.

