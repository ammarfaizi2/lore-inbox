Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSGLRAz>; Fri, 12 Jul 2002 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSGLRAy>; Fri, 12 Jul 2002 13:00:54 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:16069
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S316672AbSGLRAx>; Fri, 12 Jul 2002 13:00:53 -0400
Date: Fri, 12 Jul 2002 13:03:19 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Kirk Reiser <kirk@braille.uwo.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Advice saught on math functions
In-Reply-To: <x7d6tsewoe.fsf@speech.braille.uwo.ca>
Message-ID: <Pine.LNX.4.44.0207121253120.25178-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul 2002, Kirk Reiser wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Of course!  The maintenance cost of a kernel space solution is simply too
> > high for the single benefit of actually having speech output while the
> > kernel is in the process of booting.  And yet with an initial ramdisk
> > (initrd) containing all the user space daemon for speech I'm pretty sure we
> > can have the kernel reach the init process (or the /linuxrc process for that
> > matter) without failing in 99.9% of the cases.  This gives you virtually the
> > same result as a kernel space solution.
> 
> I don't understand this statement.  Why would the maintanance cost of
> providing speech output be any higher than serial or video or disk
> filing or anything else for that matter?

Kernel speech support maintenance is not hier than serial or disk, it's just
hier than necessary.  Better do it in user space when you get the same
functionalities.

That's also exactly what x window is doing i.e. providing video output from
user space.

That's just much, so much easier to maintain user space solutions when it's
possible to do so.  You then have the freedom to use whatever facility and
libraries available to user space as you wish.


Nicolas

