Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVJ0Roo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVJ0Roo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVJ0Roo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:44:44 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13247 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751342AbVJ0Ron (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:44:43 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Steven Rostedt <rostedt@goodmis.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: William Weston <weston@lysdexia.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <43608972.6070501@rncbc.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
	 <1130371042.21118.76.camel@localhost.localdomain>
	 <43608972.6070501@rncbc.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 27 Oct 2005 13:44:03 -0400
Message-Id: <1130435043.21118.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 09:01 +0100, Rui Nuno Capela wrote:

> 
> Don't really know if its consistent, but it does occur on several times, 
> on only on boot.

Rui,

Have you tried the last patch that I sent John?  It may just be a race
condition in the checking that causes a false positive.  My last patch
fixes that.

-- Steve


