Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269904AbUIDLtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269904AbUIDLtT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUIDLsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:48:51 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17865 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269897AbUIDLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:43:31 -0400
Date: Sat, 4 Sep 2004 12:42:43 +0100
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904114243.GC2785@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904120352.B14037@infradead.org> <Pine.LNX.4.58.0409041207060.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041207060.25475@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:12:31PM +0100, Dave Airlie wrote:
 > > > OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' link.
 > > >   I got a file called "patch-2.6.8.1.bz2".  I tried to install this but
 > > > nothing happened.  My i915 still doesn't work.  What do I do now?
 > >
 > > You could start getting a clue.
 > >
 > 
 > Which is the problem, Keith was acting as a user with no clue, and why
 > should a user who can't get his graphics card working worry about kernel
 > upgrades, along with X upgrades, the DRI has a workable snapshot process
 > now

So, how in reality is our pepsi swigging spotty quake player, going to know
he needs to run off to download the latest dri snapshot if he is so clueless ?

If our imaginary hero is so clueless he won't even know what a 'dri' is,
and nor should he. Let alone know that he needs to go grab a patch for
some subsystem.

Regardless of what the folks at Tungsten would like you to believe,
end-users *do not* like changing bits of the distro from random sources.
"a 3d driver from here, a scsi driver from there". Next time they update
their system with their update tool of choice, it pulls down a security
errata for their kernel, and whoops, their 3d has gone, their scsi controller
disappears etc etc.
The next time they see a kernel security errata available they remember the
incident, and what happens? They blame the distro for breaking their setup,
and live with a potentially insecure system.

If dri stuff isn't getting into distros fast enough, take it up with the
distros.  For Fedora at least, we have a very quick turnaround right now.

		Dave

