Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276702AbRJUUDk>; Sun, 21 Oct 2001 16:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276701AbRJUUDa>; Sun, 21 Oct 2001 16:03:30 -0400
Received: from shake.vivendi.hu ([213.163.0.180]:19330 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S276688AbRJUUDT>; Sun, 21 Oct 2001 16:03:19 -0400
Date: Sun, 21 Oct 2001 22:03:46 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: john slee <indigoid@higherplane.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Message-ID: <20011021220346.D19390@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <20011021093728.A17786@vega.digitel2002.hu> <15vI4j-1Z1VtgC@fmrl02.sul.t-online.com> <20011022013747.I5511@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20011022013747.I5511@higherplane.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 01:37:47AM +1000, john slee wrote:
> On Sun, Oct 21, 2001 at 02:54:15PM +0200, Tim Jansen wrote:
> > But what the kernel COULD do is include something like the Linux Progress 
> > Patch (http://lpp.freelords.org/). It replaces the text output of the kernel 
> > with graphics and a progress bar, so people are not frightened by cryptic 
> > text output while booting.
> 
> this is something for distributions to do...  even if the world turned
> inside out and it got included there'd be endless flamewars (and
> patches) concerning what colour the progress bar should be by default.
> 
> i read an interesting essay about that sort of thing on a freebsd list
> once - search on freebsd archives for "garden shed" or similar.

Errrm ;-) It's very bad thing to hide boot messages even for novice users.
They can't bugreport in this way ... I thing the best way would be the
penguin logo at the top, and some pixel progress bar under Tux. The messages
should remain IMHO. But this bar indicator confuses me. How do you calculate
the remaining percentage? And of course this is kernel boot only. After init,
you can start costum process to show an indicator bar to messure remaining
tasks before hitting xdm/kdm/gdm/login/whatever.

But IMHO *hiding* kernel messages is the worst thing you can do ...
Probably a versatile parameterable boot logo + indicator setting tool
should be implemented (and of course the right code to the kernel to render
them on startup). It can include (let's say:)

position and size of text area inside the screen (kernel messages)
background picture
progress bar indicator attributes, position

and so on

Again: I'm AGAINST this stupid thing but if many user wants  ...
However HIDING kernel messages would be bad move ....

Major distributions include default kernels patched for nice boot screens,
so IMHO it isn't an issue for us. A user how can COMPILE kernel himself
probably does not want gfx-only boot screens .... or at least he can patch
kernel before compile it.

- Gabor
