Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130845AbQKIOHA>; Thu, 9 Nov 2000 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbQKIOGu>; Thu, 9 Nov 2000 09:06:50 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:48653 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S130845AbQKIOGl>; Thu, 9 Nov 2000 09:06:41 -0500
Date: Thu, 9 Nov 2000 15:06:38 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Paul Jakma <paulj@itg.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <Pine.LNX.4.21.0011091332080.7475-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.21.0011091442360.17276-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Paul Jakma wrote:

> On Thu, 9 Nov 2000, Michael Rothwell wrote:
> 
> > Well, then, problem solved.
> > 
> 
> :)
> 
> > > afaik linus allows binary modules in most cases.
> > 
> > And since an "Advanced Linux Kernel Project" wouldn't be a Linus kernel,
> > what then? Would they have the same discretion as Linus? Would Linus'
> > exception apply to them?
> 
> don't know. you'd have to ask him...
> 
> I actually think Linus has been too loose/vague on modules. The
> official COPYING txt file in the tree contains an exception on linking
> to the kernel using syscalls from linus and the GPL. nothing about
> binary modules, and afaik the only statements he's ever made about
> binary modules were off the cuff on l-k a long time (unless someone
> knows a binary module whose vendor can show a written exception from
> Linus et al). 
> 
> The result of all this is that we've had plenty of vendors ignoring
> the GPL as it applies to linux and release binary modules all because
> linus said on a mailling list that he doesn't mind too much. not a
> very strong affirmation of the conditions under which linux is
> licensed.

Well, HW vendors may provide a binary module as a timid attempt to 
support Linux. A few have already understood that providing an Open Source
one is far a better attitude: they can *get* support for it from the
kernel community. They end up with a better driver, and they can even
learn something useful for their W98/NT/Sco/whatever drivers, too.
If they don't abuse of it (they are sicerely willing to "provide" something)
it's clearly a winning move.
Other vendors are just scared of the two words "Open Source" so they make
a little first step in releasing a binary only driver, which they are
more used to. I believe that sooner or later they'll realize the advantages
of the Open Source attitude, and they'll make the move.

A binary only file-system module is a completely different matter.
Legally, it may have the same "status" of a binary only driver. 
Technically, it's just another module. But it seems to me a much clearer
violation of GPL. If you want to hide the internals of your software,
you're not GPL-compatible (a driver is slightly different in that 
a HW company is probably worried about the internals of their HW).

> 
> be nice if the binary module thing could be clarified by the copyright
> holders.

Of course.

> 
> --paulj
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
