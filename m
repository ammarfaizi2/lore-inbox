Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUCYVrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUCYVrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:47:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9357 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263624AbUCYVrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:47:37 -0500
Date: Thu, 25 Mar 2004 22:48:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040325214815.GA19060@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu> <10030000.1080242684@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10030000.1080242684@flay>
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


* Martin J. Bligh <mbligh@aracnet.com> wrote:

> Exec time balancing is a *lot* more efficient, it just doesn't work
> for things that don't exec ... cloned threads would certainly be one
> case.

yeah - exec-balancing is a clear thing. fork/clone time balancing is
alot less clear.

	Ingo
