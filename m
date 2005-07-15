Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbVGOQsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbVGOQsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbVGOQsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:48:52 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:37857 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263335AbVGOQr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:47:59 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <42D7B017.4060300@tmr.com>
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
	 <1121384499.4535.82.camel@mindpipe>
	 <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org>
	 <1121394653.19939.775.camel@cmn37.stanford.edu>  <42D7B017.4060300@tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1121445983.27695.8.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2005 09:46:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 05:46, Bill Davidsen wrote:
> Fernando Lopez-Lezcano wrote:
> >On Thu, 2005-07-14 at 16:49, Linus Torvalds wrote:
> >>On Thu, 14 Jul 2005, Lee Revell wrote:
> >>>And I'm incredibly frustrated by this insistence on hard data when it's
> >>>completely obvious to anyone who knows the first thing about MIDI that
> >>>HZ=250 will fail in situations where HZ=1000 succeeds.
> >>>
> >>Ok, guys. How many people have this MIDI thing? How many of you can't be 
> >>bothered to set the default to suit your usage?
> >>
> >>>It's straight from the MIDI spec.  Your argument is pretty close to "the
> >>>MIDI spec is wrong, no one can hear the difference between 1ms and 4ms".
> >>>
> >>No.
> >>
> >>YOUR argument is "nobody else matters, only I do".
> >>
> >>MY argument is that this is a case of give and take. 
> >
> >Take from "few" multimedia users, give to "many" laptop users. Where
> >"few" and "many" are not very well defined quantities, but obviously
> >"many" > "few" :-) 
> >
> Of course that assumes that these are not the same users, which clearly 
> isn't true in all cases.

Yes, indeed, the two sets do intersect, I belong to both. I can't speak
for everybody in the "multimedia" set but in my musical work (and I
suspect many others share this view) I would rather not sacrifice timing
precision for battery life. Of course there are scenarios where the
opposite can be true, but are fewer by far (IMHO). 

-- Fernando


