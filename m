Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUIJCWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUIJCWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIJCWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:22:14 -0400
Received: from holomorphy.com ([207.189.100.168]:34176 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266880AbUIJCWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:22:12 -0400
Date: Thu, 9 Sep 2004 19:22:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910022204.GA2616@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910014228.GH11358@krispykreme> <20040910015040.GI11358@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910015040.GI11358@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:50:41AM +1000, Anton Blanchard wrote:
> Lets just make __preempt_spin_lock inline, then everything should work
> as is.

Well, there are patches that do this along with other more useful
things in the works (my spin on this is en route shortly, sorry the
response was delayed due to a power failure).


-- wli
