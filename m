Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUBZCEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUBZCEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:04:46 -0500
Received: from alt.aurema.com ([203.217.18.57]:57506 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262604AbUBZCEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:04:43 -0500
Date: Thu, 26 Feb 2004 13:04:32 +1100 (EST)
From: John Lee <johnl@aurema.com>
To: Timothy Miller <miller@techsource.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <403D3E47.4080501@techsource.com>
Message-ID: <Pine.GSO.4.03.10402261238410.8776-100000@swag.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Timothy Miller wrote:

> > Hm, I would have thought the vast majority of xmms users would be running
> > it on their own machines, to which they have root access. Hope I'm not 
> > missing something here... :-)
> 
> It's a security concern to have to login as root unnecessarily.  It's 
> bad enough we have to do that to change X11 configuration, but we 
> shouldn't have to do that every time we want to start xmms.  And just 
> suid root is also a security concern.

Ah, OK. Security point taken.

> > Assuming that all/most xmms users do have root permissions, I would think
> > that this is a very minor inconvenience... isn't xmms something which you
> > tend to start up once and leave running until you log out?

<snip>

> What about computer labs of Linux boxes where users do not own the 
> computers and are therefore not allowed to login as root.  Should they 
> be prohibited from running xmms properly?
>
> If someone does not own the box they're using, but they want to, say, 
> contribute to xmms development, they're going to be starting and 
> stopping the program quite frequently.  They're not going to have any 
> way to set the nice level.
> 
> Consider what happens if some other user logs in remotely to that 
> workstation and starts a large compile.

Valid points. I guess I've been too accustomed to playing MP3s on my own
box :-(.

> >From my testing so far, X and xmms have been the only candidates for a
> 
> They are the most talked about, so you tested them.  Fine.  But we all 
> know that they are not representative samples.  There are bound to be 
> numerous other programs that have similar problems.

No others that I've noticed yet, but yes you're probably right. Which is
why I'm really looking forward to getting feedback in this area.

> The way your scheduler works, USERS cannot "allocate CPU to their tasks 
> in any way they deem fit".  Only system administrators can.

Correct, I used the wrong word. Another symptom of too much play on my own
boxes...

> I read your paper, and I think you have some wonderful ideas.  Don't get 
> me wrong.  I think that your ideas, coupled with an interactivity 
> estimator, have an excellent chance of producing a better scheduler.

Thanks :-).

And thanks for your feedback.

Cheers,

John


