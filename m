Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVGMQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVGMQuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVGMQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:48:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54190 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261223AbVGMQq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:46:59 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <42D540C2.9060201@tmr.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org>
	 <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	 <20050712162740.GA8938@ucw.cz>  <42D540C2.9060201@tmr.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 12:46:57 -0400
Message-Id: <1121273217.4435.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:26 -0400, Bill Davidsen wrote:
> >  
> > Going to HZ=864 would fix this problem. It would likely cause other
> > problems in places that expect 1/HZ to be a sane number, though.
> > 
> But if you are going to an "odd" value, would 1381 would be a better 
> choice, given the interest in minimizing latency currently evident?

No, I think 864 is quite good enough.  1381 seems overkill even for
multimedia, people who need that can use the RTC anyway.

Lee

