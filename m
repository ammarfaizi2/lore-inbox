Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUC2LYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 06:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUC2LYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 06:24:33 -0500
Received: from ns.suse.de ([195.135.220.2]:10719 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262825AbUC2LYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 06:24:30 -0500
Date: Mon, 29 Mar 2004 08:01:50 +0200
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040329080150.4b8fd8ef.ak@suse.de>
In-Reply-To: <4068066C.507@yahoo.com.au>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
	<20040325154011.GB30175@wotan.suse.de>
	<20040325190944.GB12383@elte.hu>
	<20040325162121.5942df4f.ak@suse.de>
	<20040325193913.GA14024@elte.hu>
	<20040325203032.GA15663@elte.hu>
	<20040329084531.GB29458@wotan.suse.de>
	<4068066C.507@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004 21:20:12 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > 
> > I ported it by hand to the -mm4 scheduler now and tested it. While
> > it works marginally better than the standard -mm scheduler 
> > (you get 1 1/2 the bandwidth of one CPU instead of one) it's still
> > still much worse than the optimum of nearly 4 CPUs archived by
> > 2.4 or the standard scheduler.
> > 
> 

Sorry ignore this report - I just found out I booted the wrong
kernel by mistake. Currently retesting, also with the proposed change
to only use a single scheduling domain.

-Andi
