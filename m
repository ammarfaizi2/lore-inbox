Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWE2IJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWE2IJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWE2IJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:09:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:30470 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750763AbWE2IJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:09:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P3rAK2XA+0W6iU/O2EErKmzs1JACprCPZSQ9yV9F7cVs/ZejnLISzq5oMOhA7ohqGg4N3lcSB9xdLS8NYQQCtbYEwy6rVhvBZ5TCxTqfA32wNimWeQPVu9fx3X+F2HtzdFL7WPEsBbllG8arbBMoxFNAPumM1Ky2D/CvUicFW+4=
Message-ID: <5486cca80605290109v368057b8m9141ec18586773d3@mail.gmail.com>
Date: Mon, 29 May 2006 10:09:27 +0200
From: Antonio <tritemio@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [radeonfb]: unclean backward scrolling
Cc: "Ondrej Zary" <linux@rainbow-software.org>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Nick Warne" <nick@linicks.net>
In-Reply-To: <20060526174054.GA3361@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
	 <447356BF.2080000@rainbow-software.org> <20060526174054.GA3361@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/26/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > >I'm using the radeonfb driver with a radeon 7000 with
> > >the frambuffer
> > >at 1280x1024 on a i386 system, with a 2.6.16.17 kernel.
> > >At boot time,
> > >if I stop the messages with CTRL+s and try look the
> > >previous messages
> > >with CTRL+PagUp (backward scrolling) the screen become
> > >unreadable. In
> > >fact some lengthier lines are not erased scrolling
> > >backward and some
> > >random characters a overwritten instead. So it's very
> > >difficult to
> > >read the messages.
> > >
> > >I don't have such problem with the frambuffer at
> > >1024x768.
> > >
> > >All the previous kernels I've tried have this problem
> > >(at least up to 2.6.15).
> > >
> > >If someone can look at this issue I can provide further
> > >information.
> >
> > I have probably the same problem - but with vesafb on my
> > notebook (800x600). When I scroll back/forward or run mc
> > and then exit, it fixes itself. The problem was probably
> > always there (in 2.6.x - don't know about older
> > versions).
>
> I see it too, and it is as old as framebuffer support iirc.

Have you tried the patch early posted by Antonino A. Daplas?

For me and Nik Warne it fixes the problem.

I hope the patch is queued for inclusion...

Cheers,

  ~ Antonio
