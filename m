Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUC2UOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUC2UOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:14:47 -0500
Received: from ns.suse.de ([195.135.220.2]:54720 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263131AbUC2UOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:14:41 -0500
Date: Mon, 29 Mar 2004 22:14:34 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040329221434.4602e062.ak@suse.de>
In-Reply-To: <20040329114635.GA30093@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<20040325154011.GB30175@wotan.suse.de>
	<20040325190944.GB12383@elte.hu>
	<20040325162121.5942df4f.ak@suse.de>
	<20040325193913.GA14024@elte.hu>
	<20040325203032.GA15663@elte.hu>
	<20040329084531.GB29458@wotan.suse.de>
	<4068066C.507@yahoo.com.au>
	<20040329080150.4b8fd8ef.ak@suse.de>
	<20040329114635.GA30093@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004 13:46:35 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Sorry ignore this report - I just found out I booted the wrong kernel
> > by mistake. Currently retesting, also with the proposed change to only
> > use a single scheduling domain.
> 
> here are the items that are in the works:
> 
>   redhat.com/~mingo/scheduler-patches/sched.patch
> 
> it's against 2.6.5-rc2-mm5. This patch also reduces the rate of active
> balancing a bit.

I applied only this patch and it did slightly better than the normal -mm* 
1.5 - 2x CPU bandwidth, but still very short of the 3.7x-4x mainline
and 2.4 reach.

-Andi
