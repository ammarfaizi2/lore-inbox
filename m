Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVHaLUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVHaLUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHaLUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:20:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13786 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932396AbVHaLUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:20:30 -0400
Date: Wed, 31 Aug 2005 16:50:17 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050831112017.GD10307@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1125354385.4598.79.camel@mindpipe> <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com> <200508301701.49228.s0348365@sms.ed.ac.uk> <20050831074419.GA1029@atomide.com> <1125477566.3213.6.camel@laptopd505.fenrus.org> <20050831103402.GA6496@atomide.com> <1125486186.3213.8.camel@laptopd505.fenrus.org> <20050831111705.GC10307@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831111705.GC10307@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 04:47:05PM +0530, Srivatsa Vaddagiri wrote:
> On Wed, Aug 31, 2005 at 01:03:05PM +0200, Arjan van de Ven wrote:
> > that sounds like a fundamental issue that really needs to be fixed
> > first!
> 
> It should be fixed by the patch here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111556608901657&w=2

Actually, a solution to take care of sleeping CPUs was there quite some 
time back. The above patch only fixes a race in that solution.

Tony,
	Which kernel version did you see the slow bootup? 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
