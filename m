Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276760AbRJBWoy>; Tue, 2 Oct 2001 18:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRJBWoo>; Tue, 2 Oct 2001 18:44:44 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62963
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276758AbRJBWo1>; Tue, 2 Oct 2001 18:44:27 -0400
Date: Tue, 2 Oct 2001 15:44:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
Message-ID: <20011002154446.C1012@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 03:37:53PM -0700, Jeremy Elson wrote:
> Pavel Machek writes:
> >Hi!
> >
> >> Sorry to follow-up to my own post.  A few people pointed out that
> >> v1.00 had some Makefile problems that prevented it from building.
> >> I've released v1.02, which should be fixed.
> >
> >This should be forwared to linmodem list... Killing all those
> >binary-only modem drivers from kernel modules would be good
> >thing... Hmm, and maybe we can just hack telephony API over ltmodem
> >and be done with that. That would be good.
> >								Pavel
> 
> Hi,
> 
> Perhaps I don't understand how linmodems work to understand well
> enough how FUSD would apply - do you talk to linmodems through the
> serial driver?  If so, sounds like a good application - but we might
> still have the same problem with binary-only drivers as the
> user-to-kernel message format used by FUSD may change over time.
> (Indeed, it's already changing relative to v1.0 in response to
> some of the mail I've gotten in the past few days.)
> 

That's not good.

If there's one part of the kernel API that shouldn't change, this (or
something like it) should be it...
