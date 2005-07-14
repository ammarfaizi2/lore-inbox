Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVGNXwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVGNXwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVGNXv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:51:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49860 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262230AbVGNXuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:50:17 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
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
	 <1121383050.4535.73.camel@mindpipe>
	 <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 19:50:18 -0400
Message-Id: <1121385018.4535.85.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 16:25 -0700, Linus Torvalds wrote:
> On Thu, 14 Jul 2005, Lee Revell wrote:
> > This thread has really gone OT, but to revisit the original issue for a
> > bit, are you still unwilling to consider leaving the default HZ at 1000
> > for 2.6.13?
> 
> Yes. I see absolutely no point to it until I actually hear people who have 
> actually tried some real load that doesn't work. Dammit, I want a real 
> user who says that he can noticeable see his DVD stuttering, not some 
> theory.

Well, on the plus side, this will probably drive the development of a
mergeable variable tick solution, as I can't imagine the distros will
want to have to ship a separate HZ=1000 kernel for multimedia use.

Lee

