Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271182AbTHHMzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 08:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271298AbTHHMzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 08:55:13 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:54370 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S271182AbTHHMzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 08:55:07 -0400
Date: Fri, 8 Aug 2003 15:55:02 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       gibbs@scsiguy.com, alan@redhat.com
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1, aic7xxx-6.2.36: solid hangs)
Message-ID: <20030808125502.GB150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, gibbs@scsiguy.com, alan@redhat.com
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730181003.GC204962@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:10:03PM +0300, you [Ville Herva] wrote:
> 
> However, I just realized that all of those kernel were compiled with fairly
> dubious gcc, version 2.96-85. I just compiled otherwise identically
> configured 2.4.21-jam1 with gcc-3.2.1-2. It'll take some time to tell
> whether this cures it. This is my main suspect now.

Ok, the kernel compiled with gcc version 3.2.1 20021207 (Red Hat Linux 8.0
3.2.1-2) has now been up for more than a week. It seems stable, but I'm not
sure yet.

Which brings me to the question: which gcc version is considered most stable
for compiling 2.4.x these days?

README says:
"Make sure you have gcc 2.95.3 available.  gcc 2.91.66 (egcs-1.1.2) may
also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*"

And Documentation/Changes says:

"You may use gcc 3.0.x instead if you wish, although it may cause problems.
Later versions of gcc have not received much testing for Linux kernel
compilation, and there are almost certainly bugs (mainly, but not
exclusively, in the kernel) that will need to be fixed in order to use these
compilers."

and

"The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
the kernel correctly."

This seems to suggest 2.96-85 would be more stable than gcc-3.2.1-2. Is this
the case?
  
> > Justin, is this problem known to other boards or.. ?
> 
> The lockups may be completely unrelated to aic7xxx and the crashes on boot
> that I posted kernel logs of. I don't know.

I guess I'll poll Justin when/if the aic7xxx crashes reappear. The hang was
probably not related to aic7xxx. Sorry for the false accusation.



-- v --

v@iki.fi
