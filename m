Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271230AbRH2MtJ>; Wed, 29 Aug 2001 08:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271239AbRH2MtA>; Wed, 29 Aug 2001 08:49:00 -0400
Received: from www.heureka.co.at ([195.64.11.111]:4107 "EHLO www.heureka.co.at")
	by vger.kernel.org with ESMTP id <S271230AbRH2Msr>;
	Wed, 29 Aug 2001 08:48:47 -0400
Date: Wed, 29 Aug 2001 14:48:34 +0200
From: David Schmitt <david@heureka.co.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
Message-ID: <20010829144834.A32319@www.heureka.co.at>
In-Reply-To: <20010828154540.A23296@www.heureka.co.at> <Pine.LNX.4.30.0108282034210.1851-200000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0108282034210.1851-200000@cola.teststation.com>
User-Agent: Mutt/1.3.20i
Organization: Heureka - Der EDV-Dienstleister
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 09:46:18PM +0200, Urban Widmark wrote:
> I'm ignoring that for now (if you don't mind) and have made a patch with
> some possible improvements. Someone found a modified driver on some dlink
> server that contains (claimed) workarounds for various chip peculiarities
> (bugs).
> 
> I also added a "force software reset" that is described in the datasheet.
> Not sure what the difference is, but it can't hurt trying that if the
> normal reset fails.
> 
> Perhaps this helps, probably not.

under 'normal loads' (ie one tcp d/l at max, few other traffic) the
situation didn' get better, it hangs as often as with the original
via-rhine, at least it feels so. No hard figures here. But even
writing this mail (via ssh) here parallel to a download over the lan
(from the same server) triggers resets.

under heavy loads (ie with multiple flood pings) it resets often but I
couldn't push it over the edge anymore. I have it running now for
several minutes under multiple pingfloods and it always recovered
(from quite a amount of resets).

At least it recovers now. Thank you for your time and work!



Regards, David Schmitt
-- 
Signaturen sind wie Frauen. Man findet selten eine Vernuenftige
	-- gesehen in at.linux
