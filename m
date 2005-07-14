Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVGNX2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVGNX2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVGNX1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:27:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262816AbVGNX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:27:23 -0400
Date: Thu, 14 Jul 2005 16:25:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121383050.4535.73.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121383050.4535.73.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Lee Revell wrote:
>
> On Thu, 2005-07-14 at 09:37 -0700, Linus Torvalds wrote:
> > I have to say, this whole thread has been pretty damn worthless in
> > general in my not-so-humble opinion.
> > 
> 
> This thread has really gone OT, but to revisit the original issue for a
> bit, are you still unwilling to consider leaving the default HZ at 1000
> for 2.6.13?

Yes. I see absolutely no point to it until I actually hear people who have 
actually tried some real load that doesn't work. Dammit, I want a real 
user who says that he can noticeable see his DVD stuttering, not some 
theory.

I'm incredibly fed up with the theoretical whining. 

		Linus
