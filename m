Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCET2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCET2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVCET1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:27:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32434 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261154AbVCETAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:00:49 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>,
       nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
In-Reply-To: <4228D013.8010307@drzeus.cx>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
	 <1109876978.2908.31.camel@mindpipe>
	 <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
	 <20050303154929.1abd0a62.akpm@osdl.org> <4227ADE7.3080100@drzeus.cx>
	 <4228D013.8010307@drzeus.cx>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 14:00:47 -0500
Message-Id: <1110049247.12201.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 22:16 +0100, Pierre Ossman wrote:
> Pierre Ossman wrote:
> > Andrew Morton wrote:
> > 
> >> Mark Canter <marcus@vfxcomputing.com> wrote:
> >>  
> >>
> >>> To close this issue out of the LKML and alsa-devel, a bug report has 
> >>> been written.
> >>>
> >>> It appears to be an issue with the 'headphone jack sense' (as kde 
> >>> labels it).  The issue is in the way the 8x0 addresses the docking 
> >>> station/port replicator's audio output jack.  The mentioned quick fix 
> >>> does not work for using the ds/pr audio output, but does resolve it 
> >>> for a user that is only using headphones/internal speakers.
> >>>   
> >>
> >>
> >> But there was a behavioural change: applications which worked in 2.6.10
> >> don't work in 2.6.11, is that correct?
> >>
> >> If so, the best course of action is to change the kernel so those
> >> applications work again.  Can that be done?
> >>
> >>  
> >>
> > Yes. Speakers worked in 2.6.10 and stopped working in 2.6.11. This could 
> > be changed by setting the default for the two new volumes to muted. I 
> > don't know how this affects the issue with the docking station or the 
> > bug that this is supposed to solve though.
> > 
> 
> It seems I spoke too soon. The defaults picked by the driver are 
> actually fine. It seems to be alsactl store/restore that did something 
> strange when coming from an older kernel.
> 

So is there a bug or not?  Mark seems to be the only one affected.

It's important to follow up, because these so-called "ALSA regressions"
are generating bad press.

Lee

