Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVCDE0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVCDE0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVCCTj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:39:59 -0500
Received: from krusty.vfxcomputing.com ([66.92.20.10]:47276 "EHLO
	krusty.vfxcomputing.com") by vger.kernel.org with ESMTP
	id S262208AbVCCTGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:06:52 -0500
Date: Thu, 3 Mar 2005 14:06:38 -0500 (EST)
From: Mark Canter <marcus@vfxcomputing.com>
To: Lee Revell <rlrevell@joe-job.com>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
In-Reply-To: <1109875926.2908.26.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx>  <29495f1d05030309455a990c5b@mail.gmail.com>
  <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
 <1109875926.2908.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct, but if you want to use your headphones you would have to enable 
headphones on your mixer, which would negate your speaker output through 
your docking station's output.  If you want to use the docking station 
speakers, you would have to disable the headphones in order to get the 
docking station speakers to work; no?  If that is the case, then you would 
still have to enable/disable each time you wanted to change the direction 
of headphones/external speakers.  Again, this is not the case under <= 
2.6.10 where it works regardless of enabling/disabling headphones.

I'd hate to rant and rave here under something that has worked under 2.4.x 
and <= 2.6.10.  But this seems like a very un-userfriendly solution to 
something that has had no issues for quite some time.  In that case, what 
deemed the change necessary?  As far as I see the 8x0 driver added support 
for ICH7.  I'm sure there's more to it than just that, I just haven't 
looked into it the rest of the way.

On Thu, 3 Mar 2005, Lee Revell wrote:

> On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
>
> You don't have to disable and re-enable it each time, if your system is
> configured correctly then your mixer settings will be saved.
>
> Lee
>
