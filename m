Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVCDE00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVCDE00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVCCTkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:40:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16834 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262181AbVCCTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:09:40 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Canter <marcus@vfxcomputing.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 14:09:38 -0500
Message-Id: <1109876978.2908.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 14:06 -0500, Mark Canter wrote:
> Correct, but if you want to use your headphones you would have to enable 
> headphones on your mixer, which would negate your speaker output through 
> your docking station's output.  If you want to use the docking station 
> speakers, you would have to disable the headphones in order to get the 
> docking station speakers to work; no?  If that is the case, then you would 
> still have to enable/disable each time you wanted to change the direction 
> of headphones/external speakers.  Again, this is not the case under <= 
> 2.6.10 where it works regardless of enabling/disabling headphones.
> 
> I'd hate to rant and rave here under something that has worked under 2.4.x 
> and <= 2.6.10.  But this seems like a very un-userfriendly solution to 
> something that has had no issues for quite some time.  In that case, what 
> deemed the change necessary?  As far as I see the 8x0 driver added support 
> for ICH7.  I'm sure there's more to it than just that, I just haven't 
> looked into it the rest of the way.

Because the change was needed to make someone else's hardware work.
It's a bug, bugs happen.

If you want to complain, complain to the hardware manufacturers, who
make devices where bit $foo means $bar in one hardware revision, and
$baz in the next, and don't give us sufficient documentation to sort out
the mess.

Lee

