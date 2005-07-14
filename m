Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVGNTnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVGNTnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbVGNTn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:43:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29583 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263115AbVGNTmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:42:10 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: john stultz <johnstul@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <1121360561.3967.55.camel@laptopd505.fenrus.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	 <1121360561.3967.55.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 12:42:02 -0700
Message-Id: <1121370122.7673.161.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 19:02 +0200, Arjan van de Ven wrote:
> On Thu, 2005-07-14 at 09:37 -0700, Linus Torvalds wrote:
> > just doesn't realize that the latter is a bit more complicated exactly 
> > because the latter is a hell of a lot more POWERFUL. Trying to get rid of 
> > jiffies for some religious reason is _stupid_.
> 
> I have nothing religious against jiffies per se. My argument however is
> that with a few simple, relative interfaces *in addition* to an absolute
> interface, almost all drivers suddenly are isolated from jiffies and HZ
> because they simply don't care. Because they really DON'T care about
> absolute time. At all. 

We'll I'd probably put it as: "they do care about absolute time, but
they do not care about ticks or timer interrupt frequency"

thanks
-john


