Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVADAem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVADAem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVADAU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:20:56 -0500
Received: from mail.tmr.com ([216.238.38.203]:10765 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262036AbVADAQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:16:23 -0500
Date: Mon, 3 Jan 2005 18:53:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Willy Tarreau <willy@w.ods.org>
cc: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050103213845.GA18010@alpha.home.local>
Message-ID: <Pine.LNX.3.96.1050103184459.30038D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Willy Tarreau wrote:

> On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
>  
> > This is bizarre. iptables was made the de facto standard in 2.4.x and
> > the alternatives have issues with functionality. The 2.0/2.2 firewalling
> > interfaces are probably ready to go regardless. You do realize this is
> > what you're referring to?
> > 
> > 2 major releases is long enough.
> 
> if it's long enough, ipfwadm should not have entered 2.6 at all.

That is the truth! No one would have complained if they went away in 2.5. 
But now people are using ipchains (it was the default Redhat firewall for
a while even after iptables came out). 

> > On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> > > At the moment, the only "serious" use I've found for a 2.6 is a kexec-based
> > > bootloader for known hardware. I've already seen that maintaining it up to
> > > date is not simple, I wonder how distro people work with it... I wouldn't
> > > have to do their work right now.
> > 
> > People are already using it to run the databases their paychecks rely on.
> 
> I feel they're brave. I know several other people who went back, either because
> they didn't feel comfortable with upgrades these size, which sometimes did not
> boot because of random patches, or simply because of the scheduler which didn't
> let them type normally in an SSH session on a CPU-bound system, or even a
> proxy which performance dropped by a factor of 5 between 2.4 and 2.6. I know
> they don't report it, but they are not developpers. They see that 2.6 is not
> ready yet, and turn back to stable 2.4.

Actually one of the reasons I use 2.6, in many cases it resists hangs
which occur in 2.4. Thank Ingo, Nick and Con for that (and others) making
the scheduler far better at "plays well with others." Between the O(1)
scheduler and the HT fixes, and the various large and small tweaks of
everyone, 2.6 runs well on both large and small machines compared to 2.4.

Yes, there are exceptions.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

