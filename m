Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUHFAV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUHFAV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUHFAV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:21:59 -0400
Received: from holomorphy.com ([207.189.100.168]:8647 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268011AbUHFAVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:21:47 -0400
Date: Thu, 5 Aug 2004 17:21:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Mr. Berkley Shands" <berkley@cse.wustl.edu>, linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040806002132.GM17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"Mr. Berkley Shands" <berkley@cse.wustl.edu>,
	linux-kernel@vger.kernel.org
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805223319.GA18155@logos.cnet>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 01:46:15PM -0700, William Lee Irwin III wrote:
>> Some form of changelogging to enumerate what the contents of the
>> 2.6.6-bk6 -> 2.6.6-bk7 delta are and to reconstruct intermediate points
>> between 2.6.6-bk6 and 2.6.6-bk7 is needed.

On Thu, Aug 05, 2004 at 07:33:19PM -0300, Marcelo Tosatti wrote:
> Indeed its nasty, the problem is there is no tagging in the main BK repository
> representing the -bk tree's. It shouldnt be too hard to do something about 
> this? I can't think of anything which could help...

It would help me a lot if someone would do something about this.
Distributed development does not require that mainline be
nonreconstructible. I've had serious needs to do this kind of searching
going back to early 2.4.x on several occasions, and nothing is capable
of producing correct results (referring to attempts at cvsps + bkcvs
and other alternatives to this).


-- wli
