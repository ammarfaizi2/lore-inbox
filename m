Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRJBWiF>; Tue, 2 Oct 2001 18:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276753AbRJBWhy>; Tue, 2 Oct 2001 18:37:54 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:30220 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S276751AbRJBWhp>; Tue, 2 Oct 2001 18:37:45 -0400
Message-Id: <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices 
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28384.1002062273.1@cambot.lecs.cs.ucla.edu>
Date: Tue, 02 Oct 2001 15:37:53 -0700
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
>Hi!
>
>> Sorry to follow-up to my own post.  A few people pointed out that
>> v1.00 had some Makefile problems that prevented it from building.
>> I've released v1.02, which should be fixed.
>
>This should be forwared to linmodem list... Killing all those
>binary-only modem drivers from kernel modules would be good
>thing... Hmm, and maybe we can just hack telephony API over ltmodem
>and be done with that. That would be good.
>								Pavel

Hi,

Perhaps I don't understand how linmodems work to understand well
enough how FUSD would apply - do you talk to linmodems through the
serial driver?  If so, sounds like a good application - but we might
still have the same problem with binary-only drivers as the
user-to-kernel message format used by FUSD may change over time.
(Indeed, it's already changing relative to v1.0 in response to
some of the mail I've gotten in the past few days.)

Best,
Jer


