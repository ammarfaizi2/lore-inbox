Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSC2S0F>; Fri, 29 Mar 2002 13:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293245AbSC2SZ4>; Fri, 29 Mar 2002 13:25:56 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51187
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293510AbSC2SZl>; Fri, 29 Mar 2002 13:25:41 -0500
Date: Fri, 29 Mar 2002 10:27:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: pjd@fred001.dynip.com, robert@schwebel.de,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Networking with slow CPUs
Message-ID: <20020329182707.GG8627@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>, pjd@fred001.dynip.com,
	robert@schwebel.de,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200203291133.g2TBXsi10506@fred.cambridge.ma.us> <Pine.LNX.3.96.1020329104533.22866C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 10:47:55AM -0500, Bill Davidsen wrote:
> On Fri, 29 Mar 2002 pjd@fred001.dynip.com wrote:
> 
> > Robert Schwebel wrote:
> > > 
> > > Is there a possibility to "harden" a small machine (33 MHz embedded
> > > device) against e.g. flood pings from the outside world?
> > 
> > It *is* bleeding edge, as someone else pointed out, but you should 
> > really investigate NAPI.  It's designed to make Linux resiliant against
> > non-flow-controlled network loads like routing, which sounds like 
> > just the ticket.
> 
>   There is rate limiting in recent iptables, as well. I don't regard
> iptable as bleeding edge, so that may have a higher comfort level.
> 

Yes, but it won't keep the interrupts from all of those packets from
overloading, and DoSing it or possibly crashing the system.
