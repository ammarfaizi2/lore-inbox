Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbVJ0AJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbVJ0AJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJ0AJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:09:37 -0400
Received: from unused.mind.net ([69.9.134.98]:49387 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S1751504AbVJ0AJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:09:36 -0400
Date: Wed, 26 Oct 2005 17:02:30 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Rui Nuno Capela <rncbc@rncbc.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1130371042.21118.76.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510261656420.20624@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>  <20051021080504.GA5088@elte.hu>
 <1129937138.5001.4.camel@cmn3.stanford.edu>  <20051022035851.GC12751@elte.hu>
  <1130182121.4983.7.camel@cmn3.stanford.edu>  <1130182717.4637.2.camel@cmn3.stanford.edu>
  <1130183199.27168.296.camel@cog.beaverton.ibm.com>  <20051025154440.GA12149@elte.hu>
  <1130264218.27168.320.camel@cog.beaverton.ibm.com>  <435E91AA.7080900@mvista.com>
 <20051026082800.GB28660@elte.hu>  <435FA8BD.4050105@mvista.com>
 <435FBA34.5040000@mvista.com>  <435FEAE7.8090104@rncbc.org> 
 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
 <1130371042.21118.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Steven Rostedt wrote:

> On Wed, 2005-10-26 at 15:07 -0700, William Weston wrote:
>
> > I'm getting these with two different machines running 2.6.14-rc5-rt7 with
> > Steven's ktimer_interrupt() patch from yesterday.  Did not see these with
> > previous -rt kernels.  Shutting down NTP makes no difference.
> 
> Yeah, that ktimer_interrupt patch was for something completely
> different. Is this happening on boot up, or is this consistently
> happening?

Not during boot, but fairly consistent.  Usually a cluster of 2 or 3 every 
couple of hours.

--ww
