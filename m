Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVAQMiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVAQMiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 07:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVAQMiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 07:38:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47117 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262782AbVAQMiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 07:38:19 -0500
Date: Mon, 17 Jan 2005 13:38:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Audit Project?
Message-ID: <20050117123813.GO4274@stusta.de>
References: <41EB6691.10905@comcast.net> <20050117073217.GC13827@redhat.com> <41EB6D94.9040500@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EB6D94.9040500@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:47:32AM -0500, John Richard Moser wrote:
> 
> Damn that sucks.  I think stable releases need every patch audited
> before they get Linus' blessing, and unfortunately it seems we don't
> have the required 150+ people jumping up to volunteer.  :(
> 
> Yes I have unrealistic goals.  Sane, but unrealistic.  Perhaps
> collaboration with the major distributions to volunteer developers to do
> the auditing?  We need SOMETHING; there's been too much line noise here
> about kernel security holes.  Whether this is new or people are just
> noticing and overreacting now, it's still not good.
> 
> Unfortunately, "Something" requires manpower.  Manpower requires people
> who aren't busy doing other things, like improving preemptiveness,
> rewriting the VM system, enhancing the scheduler, or writing new
> drivers.  And unfortunately, not only is everyone busy with all of that;
> but we NEED all of that too.
> 
> Well, maybe you can't start up a group now, or implement audit policy;
> but perhaps the invitation needs to be there.  I see there are no -audit
> or -security lists on vger; perhaps somebody should start a
> linux-kernel-audit@vger list just to get the ball rolling.  If it grows
> big enough, then you can consider some policy about having the changes
> audited FIRST before releasing; for now that's just not feasible.

What exactly do you want to audit for?

If it's only for "ordinary" bugs, that's simply not feasible.
The amount of patches going into 2.6 is currently at about 3 MB every 
week. You can hardly keep up with all of that - and even if you were 
able to do so, some theoretically correct patch might break in practice 
due to hardware bugs or bugs in some toolchain.

Regarding security audits:
They aren't a bad idea, and not bound to new patches - much legacy code 
in the kernel has for sure more bugs than new code. The linus-kernel way 
for such a project is not to scream "We need SOMETHING" - the 
linux-kernel way is that you start with the work to get the ball rolling 
(and if other people are interested to work in the same area, give them 
some guidance).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

