Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285879AbRLYVaU>; Tue, 25 Dec 2001 16:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285881AbRLYVaK>; Tue, 25 Dec 2001 16:30:10 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:32987 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S285879AbRLYV3w>; Tue, 25 Dec 2001 16:29:52 -0500
Date: Tue, 25 Dec 2001 22:23:53 +0100
From: Kurt Roeckx <Q@ping.be>
To: Legacy Fishtank <garzik@havoc.gtf.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Colonel <klink@clouddancer.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 
Message-ID: <20011225222353.A2961@ping.be>
In-Reply-To: <002001c18d5f$98cb62c0$010411ac@local> <20011225141441.A14941@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011225141441.A14941@havoc.gtf.org>; from garzik@havoc.gtf.org on Tue, Dec 25, 2001 at 02:14:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2001 at 02:14:41PM -0500, Legacy Fishtank wrote:
> On Tue, Dec 25, 2001 at 05:17:01PM +0100, Manfred Spraul wrote:
> > It seems that RTNETLINK is now unconditionally enabled, I don't know
> > why.
> 
> It's required by newer RedHat and MDK initscripts, perhaps others.
> ip, iproute and similar utilities use it, and so since it's commonly
> required DaveM made it unconditional...  I think the checkin comment was
> something along the lines of "make it unconditional unless Alan
> complains about kernel bloat" :)

But ifconfig and route don't use it, and now you can't do certain
things you could before.

One thing that comes to mind is showing the ipv6 routig cache,
because it only made that proc entry when it's not enabled.

Should I mention my kernel got bigger?

(I also was under the impression that this was a stable series.)


Kurt

