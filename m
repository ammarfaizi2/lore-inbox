Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVG2Hjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVG2Hjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVG2Hjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:39:47 -0400
Received: from gate.perex.cz ([82.113.61.162]:51894 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262496AbVG2Hjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:39:39 -0400
Date: Fri, 29 Jul 2005 09:39:34 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [ALSA PATCH] 1.0.9b+
In-Reply-To: <20050728102525.234e6511.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507290929420.8400@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz>
 <20050728102525.234e6511.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Andrew Morton wrote:

> Jaroslav Kysela <perex@suse.cz> wrote:
> >
> > Linus, please do an update from:
> > 
> >    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> > 
> > ...
> >   65 files changed, 5059 insertions(+), 1122 deletions(-)
> 
> The git-alsa.patch in -mm which I obtain from
> master.kernel.org:/pub/scm/linux/kernel/git/perex/alsa-current.git is
> empty.  So we're now wanting to merge 4,000 lines of unreviewed code which
> hasn't been tested in -mm at approximately the -rc4 stage.
> 
> We need to become much better at this.

Yes, sure. I wanted to sync more early, but I had some trouble with 
cogito. Now things settled a bit, so I'll start with regular updates.

Note that most of lines are from new Sparc and ARM drivers. Other changes 
are mostly small bugfixes, cleanups and new hardware ID additions. The all 
changes goes through all ALSA developers (our CVS server sends us whole 
diffs back), so all of them review/verify new code and can fix it ASAP. It 
works quite well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
