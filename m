Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVGNPZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVGNPZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVGNPZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 11:25:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42624 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263043AbVGNPZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 11:25:34 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org
In-Reply-To: <Pine.LNX.4.62.0507140757200.31521@graphe.net>
References: <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <20050714083843.GA4851@elte.hu> <1121352941.4535.15.camel@mindpipe>
	 <Pine.LNX.4.62.0507140757200.31521@graphe.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 11:25:29 -0400
Message-Id: <1121354730.4535.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 08:02 -0700, Christoph Lameter wrote:
> I doubt that increasing the timer frequency is the way to go to solve 
> these issues. HZ should be as low as possible and we should strive for
> a tickless system.

Agreed.  Most of those applications are driven by their own interrupt
source anyway.

I do think Linus' proposal, or even copying what Windows does, would be
a big improvement over the fixed tick rate.

Lee

