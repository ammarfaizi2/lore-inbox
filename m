Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVK1AZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVK1AZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 19:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVK1AZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 19:25:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9420 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751203AbVK1AZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 19:25:27 -0500
Date: Mon, 28 Nov 2005 11:23:50 +1100
From: Nathan Scott <nathans@sgi.com>
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
       John Hawkes <hawkes@sgi.com>, Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: unable to use dpkg 2.6.15-rc2
Message-ID: <20051128002350.GC841@frodo>
References: <20051121100820.D6790390@wobbly.melbourne.sgi.com> <20051122172027.GA11219@dreamland.darkstar.lan> <20051122214443.GA781@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122214443.GA781@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 08:44:43AM +1100, Nathan Scott wrote:
> On Tue, Nov 22, 2005 at 06:20:27PM +0100, Luca wrote:
> > (please CC me, I'm not subscribed)
> > 
> > Nathan Scott <nathans@sgi.com> ha scritto:
> > >> It's reproducible in 2.6.15-rc1, 2.6.15-rc1-mm1, 2.6.15-rc1-mm2 and
> > >> 2.6.15-rc2.
> > >> 
> > >> It does not occur in 2.6.14.
> > >> 
> > >> Most easily triggered by "make clean" in the Linux source, for those of
> > >> you without access to dpkg. But both clean and dpkg will trigger it.
> > > 
> > > So far I've not been able to reproduce this; I'm using "make clean"
> > > and it works just fine for me (I'm using the current git tree).
> > 
> > Confirmed here with 2.6.15-rc1 an IDE disk. Kernel is UP with
> > CONFIG_PREEMPT and 8KB stack. The following debug options are enabled:
> > 
> 
> Keith Owens has managed to reproduce this locally, and has been
> working on tracking it back to a single change - so, we'll start
> trying to figure out whats gone wrong here shortly, and will get
> a fix merged as soon as we can.

FYI - this problem is now fixed in Linus' current git tree.

cheers.

-- 
Nathan
