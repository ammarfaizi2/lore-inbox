Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVAEF57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVAEF57 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVAEF57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:57:59 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41997 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262258AbVAEF54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:57:56 -0500
Date: Wed, 5 Jan 2005 06:49:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, davidsen@tmr.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
Message-ID: <20050105054912.GC24263@alpha.home.local>
References: <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104201750.GB22075@alpha.home.local> <1104879221.17176.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104879221.17176.69.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, Jan 05, 2005 at 12:02:01AM +0000, Alan Cox wrote:
> We employ a small army of highly qualified QA and engineering people to
> do that. It's very very hard work. In addition we make choices that suit
> our business customers but would be very bad for progress if they were
> the "base". To a lot of our customers progress is evil unless they can
> schedule it six months in advance. 

Oh, you know, I have customers who already moan about the too high rate of
updates in rhel3 because they can't keep all their machines to the same
version.

> If the base kernel worked that way we'd not have gotten a useful OS yet.
> Don't confuse the deployment goals of big business and the developer
> goals of the community. If you stand in the middle you get stretched
> into strange directions and eventually (as we found with the Fedora v
> RHEL split) you can't do both at the same time.

Well, I know we're often tempted to include our very last work with bugfixes
in an update, but I mean that if the work has already been done (internally),
I wonder why it cannot be done publicly. Except of course if the people
working on this are not really linked to mainline kernel development, which
I could understand.

> > one works for me" and stick to it for a time. Indeed, I think that if 2.6.11
> > would stay a year in -rc version, then Alan would release tens of 2.6.10
> > derivatives which would then become far more stable than what the next 2.6.11
> > would be.
> 
> It always depends "at what". 2.6.10 is more stable than 2.6.9-ac at SCSI
> and USB for example because the backports were too complex.

That's not a problem, and it's even expected. In your kernel, you fix "easy"
things and you publicly state that USB or SCSI will not get fixed. Then you
provide people with a working 2.6 at a feature level equivalent to 2.6.9.
All those who are not hit with SCSI or USB are fairly happy. Others just have
to wait for the 2.6.10 updates which change SCSI and USB, and already expect
that it breaks a few things given the number of changes. Your kernels provide
the needed fourth digit numbering in some ways.

Cheers,
Willy

