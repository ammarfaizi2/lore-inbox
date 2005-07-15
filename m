Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVGORBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVGORBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbVGORBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:01:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47823 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263347AbVGOQ7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:59:50 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Con Kolivas <kernel@kolivas.org>, Linus Torvalds <torvalds@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.61.0507142254140.16055@montezuma.fsmlabs.com>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121383050.4535.73.camel@mindpipe>
	 <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
	 <200507151408.39932.kernel@kolivas.org> <1121401043.12420.5.camel@mindpipe>
	 <Pine.LNX.4.61.0507142254140.16055@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 12:59:54 -0400
Message-Id: <1121446794.12420.30.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 22:54 -0600, Zwane Mwaikambo wrote:
> On Fri, 15 Jul 2005, Lee Revell wrote:
> 
> > On Fri, 2005-07-15 at 14:08 +1000, Con Kolivas wrote:
> > > Audio did show slightly larger max latencies but nothing that would be of 
> > > significance.
> > > 
> > > On video, maximum latencies are only slightly larger at HZ 250, all the 
> > > desired cpu was achieved, but the average latency and number of missed 
> > > deadlines was significantly higher.
> > 
> > Because audio timing is driven by the soundcard interrupt while video,
> > like MIDI, relies heavily on timers.
> 
> In interbench it's not driven by a soundcard interrupt.
> 
> 

OK.  Con, any idea why video is so much more affected than audio?

Lee

