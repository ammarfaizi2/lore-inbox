Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUIJMQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUIJMQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUIJMQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:16:56 -0400
Received: from holomorphy.com ([207.189.100.168]:53379 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267382AbUIJMQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:16:48 -0400
Date: Fri, 10 Sep 2004 05:16:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910121639.GD2616@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910014228.GH11358@krispykreme> <20040910015040.GI11358@krispykreme> <20040910022204.GA2616@holomorphy.com> <20040910074033.GA27722@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910074033.GA27722@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> Well, there are patches that do this along with other more useful
>> things in the works (my spin on this is en route shortly, sorry the
>> response was delayed due to a power failure).

On Fri, Sep 10, 2004 at 09:40:34AM +0200, Ingo Molnar wrote:
> i already sent the full solution that primarily solves the SMP &&
> PREEMPT latency problems but also solves the section issue, two days
> ago:
>    http://lkml.org/lkml/2004/9/8/97

When I noticed there was work to do along the lines of creating
read_trylock() primitives I dropped the ->break_lock -less variant I
had brewed up and directed Linus to your patch.


-- wli
