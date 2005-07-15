Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbVGOEvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbVGOEvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVGOEvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:51:47 -0400
Received: from fsmlabs.com ([168.103.115.128]:26297 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263205AbVGOEvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:51:47 -0400
Date: Thu, 14 Jul 2005 22:54:39 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Con Kolivas <kernel@kolivas.org>, Linus Torvalds <torvalds@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121401043.12420.5.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0507142254140.16055@montezuma.fsmlabs.com>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121383050.4535.73.camel@mindpipe>
  <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>  <200507151408.39932.kernel@kolivas.org>
 <1121401043.12420.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Lee Revell wrote:

> On Fri, 2005-07-15 at 14:08 +1000, Con Kolivas wrote:
> > Audio did show slightly larger max latencies but nothing that would be of 
> > significance.
> > 
> > On video, maximum latencies are only slightly larger at HZ 250, all the 
> > desired cpu was achieved, but the average latency and number of missed 
> > deadlines was significantly higher.
> 
> Because audio timing is driven by the soundcard interrupt while video,
> like MIDI, relies heavily on timers.

In interbench it's not driven by a soundcard interrupt.

