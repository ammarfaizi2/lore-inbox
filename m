Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbSJGPos>; Mon, 7 Oct 2002 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJGPos>; Mon, 7 Oct 2002 11:44:48 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:23980 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S263132AbSJGPoq>; Mon, 7 Oct 2002 11:44:46 -0400
Date: Mon, 7 Oct 2002 09:15:28 -0700
From: Matt Porter <porter@cox.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, giduru@yahoo.com,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
Message-ID: <20021007091528.A18610@home.com>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021005205238.47023.qmail@web13201.mail.yahoo.com> <20021005.212832.102579077.davem@redhat.com> <1033923206.21282.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033923206.21282.28.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 06, 2002 at 05:53:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 05:53:26PM +0100, Alan Cox wrote:
> On Sun, 2002-10-06 at 05:28, David S. Miller wrote:
> > Embedded applications tend to have issues which are entirely specific
> > to that embedded project.  As such, those are things that do not
> > belong in a general purpose OS.
> 
> 90% of the embedded Linux problem is not this. Its actually easy to get
> most of the embedded needs into the base kernel - in fact they overlap
> the other worlds a lot.
 
No argument there.

<snip>

> No the big problem is that each embedded vendor is desperately trying to
> keep their changes out of the mainstream so they can screw each other.
> In doing so the main people they screw are all their customers.

I just don't see much of this at the embedded linux vendor that
brings my check.  Everything gets pushed out somewhere.  I know
with some of the smaller embedded linux players I don't see any
participation, but I'm not sure where you've developed this
viewpoint ... oh perhaps it is from lkml participation?

Let's think about that...many embedded developers have been around
for years, some may have been more active in core kernel discussions
on lkml (RMK) but others have been extremely active in arch-specific
development.  You don't hear from them because there is such a huge
amount of work masked out by blobs of merges from the arch maintainers.
For example, we have a very strong group of people working on Linux/PPC
many of which have been around for years making the tree organized
for the many board ports that need to be done, reacting to breakage
from ia32-oriented development, etc.  The issues are a little different
in that we keep getting new sub-families of PPC processors and new
boards everyday that don't follow a semi-standard PC architecture.
Most of our time is spent just enabling these systems and working
out arch-specific issues.

That said, I have a laundry list of "mainstream" things like
>32-bit phys remap_page_range, 64-bit resources, and PCI MSI
support I'd like to work on.  It just takes time and it's more
important to fix fundamentals like our PPC 4xx SoC
infrastructure. :)

> So if the embedded people want 2.6 to be good at embedded they need to
> get their heads out of their arses and contribute to the mainstream.
> Otherwise they'll always be chasing a moving ball, and a ball most
> people are kicking the other way down the field. Its a simple fact of
> line, if you stick you head up your backside all you get to do is eat
> shit
> 
> (and yes there are some embedded people who do contribute but they are
> sadly a real minority)

Thanks for not completely diminishing our work. 

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
