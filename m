Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318845AbSHWPag>; Fri, 23 Aug 2002 11:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318860AbSHWPag>; Fri, 23 Aug 2002 11:30:36 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:20352 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318845AbSHWPag>; Fri, 23 Aug 2002 11:30:36 -0400
Date: Fri, 23 Aug 2002 11:34:43 -0400
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cell-phone like keyboard driver anywhere?
Message-ID: <20020823153442.GA29846@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Holger Schurig <h.schurig@mn-logistik.de>,
	linux-kernel@vger.kernel.org
References: <200208210932.36132.h.schurig@mn-logistik.de> <200208230954.11132.h.schurig@mn-logistik.de> <20020823142140.GA27454@ravel.coda.cs.cmu.edu> <200208231710.19950.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208231710.19950.h.schurig@mn-logistik.de>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 05:10:19PM +0200, Holger Schurig wrote:
> > Press 5 (JKL), all songs starting with either j, k, or l will be
> > selected, and the display shows 'Kind of Magic'. Press 3 (DEF) and it
> > limits the selection to any songs that have one of those letters in the
> 
> That sounds pretty much like high application stuff. If I had that in my mind, 
> I would not have had asked in linux-KERNEL. For an application it's easy to 
> have some directory.
> 
> The solution you're proposing is good and elegant --- in it's domain. It 
> solves one narrow problem. I need a solution that is broader. Your solution 
> wouldn't work with Qt/Embedded apps AND X11 apps AND ncurses apps. Maybe 
> because your hardware is only used for playing mpegs. But what if the 

The hardware in not just used to play mpegs. It is one application that
happens to be running most of the time, and it is the application that
deals with treating the input in such a way.

You want a broader solution, just look at how grafitti input (penstrokes)
is dealt with in for example Qt/Embedded or X11 on the iPaq. No kernel
hacks involved there as far as I can see.

    http://www.handhelds.org/
    http://www.handhelds.org/projects/xscribble.html

Or have a library that intercepts read() from fd 0 which you link
against applications.

Jan
