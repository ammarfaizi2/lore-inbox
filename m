Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUGIG6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUGIG6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 02:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGIG6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 02:58:40 -0400
Received: from holomorphy.com ([207.189.100.168]:14570 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264461AbUGIG6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 02:58:39 -0400
Date: Thu, 8 Jul 2004 23:58:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040709065830.GY21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	"David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com> <20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com> <40EE06B1.1090202@yahoo.com.au> <20040709025151.GV21066@holomorphy.com> <40EE288F.20301@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EE288F.20301@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Please present a self-contained fixed-up init_idle() cleanup for me to
>> testboot. Even the one in -mm is not so, as it depends on later patches
>> to even compile.

On Fri, Jul 09, 2004 at 03:09:35PM +1000, Nick Piggin wrote:
> The patch I just sent (which is on top of -mm6) should hopefully
> work... if you feel like testing a solution that may still get
> vetoed by Ingo.
> Also, what compile errors are you getting? i386 seems to compile
> kernel/ fine with only the first sched- patch applied.

"atop -mm6" is not what I'd call a self-contained patch. I'm relatively
irritated about the approach to (or perhaps even avoidance of) testing
in isolation going on here. I have other things I very urgently need to
do, and I doubt whatever I get for doing your homework for you will pay
for screwing up public presentations. I have had enough trouble in
general isolating causes of failures, so please prep this properly.


-- wli
