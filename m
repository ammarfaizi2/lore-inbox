Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbULIXM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbULIXM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbULIXM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:12:59 -0500
Received: from mail.timesys.com ([65.117.135.102]:39748 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261663AbULIXMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:12:54 -0500
Message-ID: <41B8DB4E.5020806@timesys.com>
Date: Thu, 09 Dec 2004 18:10:06 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
References: <20041124101626.GA31788@elte.hu>	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>	 <20041207141123.GA12025@elte.hu>	 <1102526018.25841.308.camel@localhost.localdomain>	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>	 <1102532625.25841.327.camel@localhost.localdomain>	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>	 <1102543904.25841.356.camel@localhost.localdomain>	 <20041209093211.GC14516@elte.hu>  <20041209131317.GA31573@elte.hu>	 <1102602829.25841.393.camel@localhost.localdomain>	 <1102619992.3882.9.camel@localhost.localdomain>	 <41B8B6A0.5030101@timesys.com> <1102630749.3236.5.camel@localhost.localdomain>
In-Reply-To: <1102630749.3236.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2004 23:05:21.0031 (UTC) FILETIME=[8EA10970:01C4DE43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

> Could you do me a big favor? Put a print in mm/highmem.c bounce_copy_vec
> to see if you get into it.  If you don't then it seems that my system is
> triggering this and it just so happens that yours does not.

Did so.  For whatever reason I don't appear to be getting into
bounce_copy_vec() during bootup as you seem to be.

-john


-- 
john.cooper@timesys.com
