Return-Path: <linux-kernel-owner+w=401wt.eu-S1751450AbXAFSg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbXAFSg2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXAFSg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:36:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44753 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbXAFSg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:36:27 -0500
Date: Sat, 6 Jan 2007 19:32:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
Message-ID: <20070106183201.GA14238@elte.hu>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com> <1168064710.20372.28.camel@localhost.localdomain> <20070106070807.GA11232@elte.hu> <1168105353.20372.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168105353.20372.39.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> I moved drm_follow_page into the core, to avoid having to wrap the 
> various pte ops.  Unlining kernel_fpu_end and using that in the RAID6 
> code would remove the need to export clts/read_cr0/write_cr0 too.

yeah, let's do that too.

	Ingo
