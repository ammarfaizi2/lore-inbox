Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUC2L7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 06:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUC2L7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 06:59:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18925 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262815AbUC2L7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 06:59:52 -0500
Date: Mon, 29 Mar 2004 13:46:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, jun.nakajima@intel.com,
       ricklind@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040329114635.GA30093@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu> <20040325162121.5942df4f.ak@suse.de> <20040325193913.GA14024@elte.hu> <20040325203032.GA15663@elte.hu> <20040329084531.GB29458@wotan.suse.de> <4068066C.507@yahoo.com.au> <20040329080150.4b8fd8ef.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329080150.4b8fd8ef.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Sorry ignore this report - I just found out I booted the wrong kernel
> by mistake. Currently retesting, also with the proposed change to only
> use a single scheduling domain.

here are the items that are in the works:

  redhat.com/~mingo/scheduler-patches/sched.patch

it's against 2.6.5-rc2-mm5. This patch also reduces the rate of active
balancing a bit.

	Ingo
