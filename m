Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTJ0Uxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTJ0Uxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:53:51 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:52367 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id S263582AbTJ0Uxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:53:34 -0500
Date: Mon, 27 Oct 2003 15:53:34 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, ian.soboroff@nist.gov,
       linux-kernel@vger.kernel.org
Subject: Re: APM suspend still broken in -test9
Message-ID: <20031027155334.B21342@sventech.com>
References: <Pine.LNX.4.44.0310271219040.13116-100000@cherise> <3F9D84BA.7070904@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F9D84BA.7070904@pacbell.net>; from david-b@pacbell.net on Mon, Oct 27, 2003 at 12:48:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003, David Brownell <david-b@pacbell.net> wrote:
> Patrick Mochel wrote:
> > On Mon, 27 Oct 2003, David Brownell wrote:
> > 
> >>Those are the same symptoms I saw in test7, fixed by:
> >>
> >>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2
> >>
> >>Patrick, were you going to submit your patch to resolve this?
> >>I'm thinking this kind of problem would meet Linus's test10
> >>integration criteria.
> > 
> > I should be merging early this week. Sorry about the delay, but it will 
> > get in soon.
> 
> Good -- I just wanted to make sure it didn't get lost, more
> folk are noticing it lately.
> 
> > BTW, can you help with any of the uhci-hcd suspend/resume issues? I do not 
> > know the code well enough to track it down.. 
> 
> I'm trying to avoid that; sorry!  Some of them could be related to UHCI
> patches that are waiting for feedback/approval from Johannes.

Which patches do you suspect are related? It's hard for me to test
anything suspend/resume related with UHCI since I don't have any systems
with a UHCI controller that would be affected.

However, I can (well, I should have already...) eyeball the patches
atleast.

JE

