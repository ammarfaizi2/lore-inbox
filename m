Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263239AbVGOIWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbVGOIWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVGOIWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:22:11 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:15781 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263239AbVGOIWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:22:09 -0400
X-Envelope-From: kraxel@suse.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	<20050714005106.GA16085@taniwha.stupidest.org>
	<Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	<1121304825.4435.126.camel@mindpipe>
	<Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	<1121326938.3967.12.camel@laptopd505.fenrus.org>
	<20050714121340.GA1072@ucw.cz>
	<Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	<1121360561.3967.55.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>
	<20050714200926.C10410@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0507141302210.19183@g5.osdl.org>
From: Gerd Knorr <kraxel@suse.de>
Organization: SUSE Labs, Berlin
Date: 15 Jul 2005 10:15:33 +0200
In-Reply-To: <Pine.LNX.4.58.0507141302210.19183@g5.osdl.org>
Message-ID: <8764vclc2i.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Now, if somebody wants to make nicer helper functions so that you can say
> 
> 	timeout = ms_from_now(500);

We already have something very simliar:
        timeout = jiffies + msecs_to_jiffies(500);

;)

  Gerd

-- 
panic("it works"); /* avoid being flooded with debug messages */
