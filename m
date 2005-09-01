Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVIAGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVIAGhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVIAGhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:37:04 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:56217 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932374AbVIAGhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:37:03 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 1 Sep 2005 09:36:19 +0300
From: Tony Lindgren <tony@atomide.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050901063619.GA10677@atomide.com>
References: <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com> <200508301701.49228.s0348365@sms.ed.ac.uk> <20050831074419.GA1029@atomide.com> <1125477566.3213.6.camel@laptopd505.fenrus.org> <20050831103402.GA6496@atomide.com> <1125486186.3213.8.camel@laptopd505.fenrus.org> <20050831111705.GC10307@in.ibm.com> <20050831112017.GD10307@in.ibm.com> <20050831132109.GD6496@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831132109.GD6496@atomide.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [050831 16:21]:
> * Srivatsa Vaddagiri <vatsa@in.ibm.com> [050831 14:20]:
> > On Wed, Aug 31, 2005 at 04:47:05PM +0530, Srivatsa Vaddagiri wrote:
> > > On Wed, Aug 31, 2005 at 01:03:05PM +0200, Arjan van de Ven wrote:
> > > > that sounds like a fundamental issue that really needs to be fixed
> > > > first!
> > > 
> > > It should be fixed by the patch here:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=111556608901657&w=2
> > 
> > Actually, a solution to take care of sleeping CPUs was there quite some 
> > time back. The above patch only fixes a race in that solution.
> > 
> > Tony,
> > 	Which kernel version did you see the slow bootup? 
> 
> I'll try it out, but sounds like it won't help then.
> 
> This is on ARM OMAP and 2.6.12. I haven't been able to play with the
> x86 stuff lately, hopefully will have a chance soonish...

It could be that the slow bootup is currently just OMAP specific issue,
I'll post more info when I find out.

Tony
