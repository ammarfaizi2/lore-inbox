Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265259AbSKAA1j>; Thu, 31 Oct 2002 19:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265525AbSKAA1j>; Thu, 31 Oct 2002 19:27:39 -0500
Received: from almesberger.net ([63.105.73.239]:2824 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265259AbSKAA1h>; Thu, 31 Oct 2002 19:27:37 -0500
Date: Thu, 31 Oct 2002 21:33:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Bernhard Kaindl <bk@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       lkcd-general@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021031213345.D2599@almesberger.net>
References: <20021031160800.M18072@redhat.com> <Pine.LNX.4.33.0210312221490.6945-100000@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210312221490.6945-100000@wotan.suse.de>; from bk@suse.de on Thu, Oct 31, 2002 at 11:04:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Kaindl wrote:
> An analogy to doctors, hospitals and patients:

I have a simpler medical analogy:

 - in many cases, all you know is that the patient died
   (e.g. think of a router - it has no console, no user
   interacting with it, etc.)
 - the Oops tells you the the patient died of a heart failure
   (NULL pointer dereferenced in this or that function, called
   from ...)
 - but it's only the autopsy (the crash dump) that reveals that
   the patient was poisoned, and that this is not a routine
   case

I view crash dumps as a tool that helps me imagine what the
machine was doing. Without that, I can learn many interesting
things about the code, but I won't necessarily find the actual
bug.

Examples of non-obvious bugs can be found in the various module
unload race discussions. There, usually competent people
suggested incorrect designs, simply because they failed to
imagine some constellations, and no amount of staring at the
source could have helped this lack of imagination.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
