Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVGNBdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVGNBdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVGNBdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:33:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48778 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262319AbVGNBds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:33:48 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
References: <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 21:33:45 -0400
Message-Id: <1121304825.4435.126.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 18:13 -0700, dean gaudet wrote:
> On Wed, 13 Jul 2005, Chris Wedgwood wrote:
> 
> > On Wed, Jul 13, 2005 at 04:41:41PM -0700, dean gaudet wrote:
> > 
> > > windows xp base rate is 100Hz... but multimedia apps can ask for
> > > almost any rate they want (depends on the hw capabilities).  i
> > > recall seeing rates >1200Hz when you launch some of the media player
> > > apps -- sorry i forget the exact number.
> > 
> > Windows starts an additional high-speed timer as needed for this?
> 
> i don't think so -- i think it reprograms the divisor... but don't trust 
> me, check this doc:
> 
> http://www.microsoft.com/whdc/system/CEC/mm-timer.mspx
> 
> it goes into detail on the current and future timer support in winxp.

Interesting.  First they say it's impractical to reprogram the PIT, then
they later imply that's exactly what Windows does, though for some
reason they don't come out and say it.

Lee

