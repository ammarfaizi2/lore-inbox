Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVG2CJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVG2CJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 22:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVG2CJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 22:09:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262133AbVG2CIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 22:08:53 -0400
Date: Thu, 28 Jul 2005 19:07:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: perex@suse.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [ALSA PATCH] 1.0.9b+
Message-Id: <20050728190742.1080a325.akpm@osdl.org>
In-Reply-To: <200507282334.23910.s0348365@sms.ed.ac.uk>
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz>
	<20050728102525.234e6511.akpm@osdl.org>
	<200507282334.23910.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
>
> On Thursday 28 Jul 2005 18:25, Andrew Morton wrote:
> > Jaroslav Kysela <perex@suse.cz> wrote:
> > > Linus, please do an update from:
> > >
> > >    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> > >
> > > ...
> > >   65 files changed, 5059 insertions(+), 1122 deletions(-)
> >
> > The git-alsa.patch in -mm which I obtain from
> > master.kernel.org:/pub/scm/linux/kernel/git/perex/alsa-current.git is
> > empty.  So we're now wanting to merge 4,000 lines of unreviewed code which
> > hasn't been tested in -mm at approximately the -rc4 stage.
> 
> ~2800 lines of which is a new driver.
> 
> It'd be nice if ALSA's release schedule for "stable" versus "rc" could match 
> the kernel's. For example, 2.6.12 shipped with 1.0.9rc2.
> 
> Maybe "rc" ALSA should only be accepted in rc1, by rc4 you hope they can wrap 
> things up and give you a stable version number? Okay, generally in-tree 
> version numbers don't count for much, but I think ALSA is a big exception 
> because it's maintained pretty much out of tree.
> 
> Not so much of an issue this time around, but I don't think new drivers or 
> rewrites (even if they are reasonably separate) should be going in a late -rc 
> kernel.
> 

Independent of all that, there remains the problem that I was not obtaining
all this new code from
master.kernel.org:/pub/scm/linux/kernel/git/perex/alsa-current.git.

Is there some different tree which I should be pulling from?
