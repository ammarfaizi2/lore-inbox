Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVGNROF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVGNROF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVGNRLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:11:49 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:55785 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261607AbVGNRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:11:23 -0400
Message-ID: <42D69C6F.9030301@nortel.com>
Date: Thu, 14 Jul 2005 11:10:07 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> <20050714005106.GA16085@taniwha.stupidest.org> <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org> <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> There's absolutely nothing wrong with "jiffies", and anybody who thinks 
> that
> 
> 	msleep(20);
> 
> is fundamentally better than
> 
> 	timeout = jiffies + HZ/50;
> 
> just doesn't realize that the latter is a bit more complicated exactly 
> because the latter is a hell of a lot more POWERFUL.

But if all I really want is to sleep for 20ms, what does the additional 
power actually buy me?

Chris
