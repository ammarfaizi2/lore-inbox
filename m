Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUIOPD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUIOPD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUIOPD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:03:59 -0400
Received: from mail.tmr.com ([216.238.38.203]:36624 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266349AbUIOPD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:03:56 -0400
Date: Wed, 15 Sep 2004 10:56:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
In-Reply-To: <AECBE898-036B-11D9-B8B0-000393ACC76E@mac.com>
Message-ID: <Pine.LNX.3.96.1040915105100.10950B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Kyle Moffett wrote:

> On Sep 10, 2004, at 14:12, Bill Davidsen wrote:
> > I like that a lot!
> >   Use 8250 serial? (Y/n/m/b)
> 
> What's this mean? Yes/No/Module/Butter? :-D

Thought the original was clear, b=BLOCK to block the use of the feature. I
have no strong feelings on this, although forceno isn't intuitive, people
will forget if it mean force on or off.
> 
> Perhaps better: (r/Y/m/n/f), for required/yes/module/no/forceno
> 
> If anything contradicts required or forceno, it throws an error?

I would say so, but better yet would be to grey out anything requiring the
option. The whole idea of forcing options on behind the scenes is a
problem in human interface.

New thought: how about prompting the user with something like
  CONFIG_DANCING_PENGUINS requires CONFIG_VESAFB, enable or skip (e/s)?

or something of that flavor.

> 
> Cheers,
> Kyle Moffett

I have no doubt that other will weigh in on this.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

