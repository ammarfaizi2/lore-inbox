Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVHaKuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVHaKuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHaKuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:50:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61654 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932319AbVHaKuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:50:37 -0400
Date: Wed, 31 Aug 2005 16:20:00 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050831105000.GB10307@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1125354385.4598.79.camel@mindpipe> <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com> <200508301701.49228.s0348365@sms.ed.ac.uk> <20050831074419.GA1029@atomide.com> <1125477566.3213.6.camel@laptopd505.fenrus.org> <20050831103402.GA6496@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831103402.GA6496@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 01:34:03PM +0300, Tony Lindgren wrote:
> Well it seems like the next_timer_interrupt is something like 400
> jiffies away and RCU code waits for completion for example in the
> network code.

I had a patch to fix the problem of "RCU grace period extended 
because of sleeping idle CPUs". I had posted the patch here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111556608901657&w=2

Will send out this patch against latest tree for Andrew to pick it.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
