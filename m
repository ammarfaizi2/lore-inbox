Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263611AbUEEHeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUEEHeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 03:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUEEHeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 03:34:14 -0400
Received: from holomorphy.com ([207.189.100.168]:36495 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263611AbUEEHeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 03:34:10 -0400
Date: Wed, 5 May 2004 00:24:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, ashok.raj@intel.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       John Reiser <jreiser@BitWagon.com>, mike@navi.cx, pageexec@freemail.hu,
       Matthew Dobson <colpatch@us.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: various cpu patches [was: (resend) take3: Updated CPU Hotplug patches]
Message-ID: <20040505072431.GG1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
	ashok.raj@intel.com, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
	John Reiser <jreiser@BitWagon.com>, mike@navi.cx,
	pageexec@freemail.hu, Matthew Dobson <colpatch@us.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040504225907.6c2fe459.akpm@osdl.org> <20040505000348.018f88bb.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505000348.018f88bb.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 12:03:48AM -0700, Paul Jackson wrote:
> Hmmm .. we're getting backed up here.  Sure glad Andrew's got the job of
> conducting this, not me ...
> The purpose of this message is to list several patches that are
> interacting, and the order that I'm guessing Andrew will end up taking
> them.  I claim no authority, and at best very limited forecasting
> ability.
> This is just to put a source of possible confusions on the table,
> by running it up the flagpole, and inviting the shooting to begin.
> The following patches are colliding or interacting, listed in the order
> that I'm guessing they will end up going into *-mm, and with my guess of
> their current status:
>   1. Nick Piggin's sched_domains patches (in *-mm now)
>   2. Ashok Raj's CPU Hotplug patches for IA64 (sent back to author for repair)
>   3. Paul Jackson's bitmap/cpumask cleanup (in my workarea ready to submit)
>   4. John Reiser's bssprot (unrelated, except for ia64 friendly fire damage)
>   5. Matthew Dobson's nodemask_t (in Matthew's workarea, ready to submit)
>   6. Andi Kleen's numa placement (being reviewed now, I think)

I don't see any essential interaction between these patches. This appears
to be 100% mergewerk. I don't think there's any essential conflict, just
potential PITA rediffing for the (re)senders if/when they touch the same
lines of code and things get accepted in a different order from what ppl
merged their stuff against. As far as I'm concerned, business as usual.

-- wli
