Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSGLQ10>; Fri, 12 Jul 2002 12:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSGLQ1Z>; Fri, 12 Jul 2002 12:27:25 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:9684 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S316632AbSGLQ1Y>; Fri, 12 Jul 2002 12:27:24 -0400
To: Nicolas Pitre <nico@cam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Advice saught on math functions
References: <Pine.LNX.4.44.0207121102230.25178-100000@xanadu.home>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 12 Jul 2002 12:30:09 -0400
In-Reply-To: <Pine.LNX.4.44.0207121102230.25178-100000@xanadu.home>
Message-ID: <x7d6tsewoe.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Of course!  The maintenance cost of a kernel space solution is simply too
> high for the single benefit of actually having speech output while the
> kernel is in the process of booting.  And yet with an initial ramdisk
> (initrd) containing all the user space daemon for speech I'm pretty sure we
> can have the kernel reach the init process (or the /linuxrc process for that
> matter) without failing in 99.9% of the cases.  This gives you virtually the
> same result as a kernel space solution.

I don't understand this statement.  Why would the maintanance cost of
providing speech output be any higher than serial or video or disk
filing or anything else for that matter?

I like the rest of your observations though and want to look over your
article in more depth and think about it.  On first glance though,
modifying vcsa0 to support select is pretty much the same as providing
an output hook the same as I've done in speakup already.

This has somewhat strayed from my original questions though. 'wink'

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
