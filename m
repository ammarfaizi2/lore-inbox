Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUIJHjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUIJHjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUIJHjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:39:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5318 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263664AbUIJHjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:39:22 -0400
Date: Fri, 10 Sep 2004 09:40:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910074033.GA27722@elte.hu>
References: <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910014228.GH11358@krispykreme> <20040910015040.GI11358@krispykreme> <20040910022204.GA2616@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910022204.GA2616@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> On Fri, Sep 10, 2004 at 11:50:41AM +1000, Anton Blanchard wrote:
> > Lets just make __preempt_spin_lock inline, then everything should work
> > as is.
> 
> Well, there are patches that do this along with other more useful
> things in the works (my spin on this is en route shortly, sorry the
> response was delayed due to a power failure).

i already sent the full solution that primarily solves the SMP &&
PREEMPT latency problems but also solves the section issue, two days
ago:

   http://lkml.org/lkml/2004/9/8/97

	Ingo
