Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVG1Wij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVG1Wij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVG1Wf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:35:58 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:61873 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261707AbVG1WeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:34:23 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [ALSA PATCH] 1.0.9b+
Date: Thu, 28 Jul 2005 23:34:23 +0100
User-Agent: KMail/1.8.1
Cc: Jaroslav Kysela <perex@suse.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz> <20050728102525.234e6511.akpm@osdl.org>
In-Reply-To: <20050728102525.234e6511.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507282334.23910.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 Jul 2005 18:25, Andrew Morton wrote:
> Jaroslav Kysela <perex@suse.cz> wrote:
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

~2800 lines of which is a new driver.

It'd be nice if ALSA's release schedule for "stable" versus "rc" could match 
the kernel's. For example, 2.6.12 shipped with 1.0.9rc2.

Maybe "rc" ALSA should only be accepted in rc1, by rc4 you hope they can wrap 
things up and give you a stable version number? Okay, generally in-tree 
version numbers don't count for much, but I think ALSA is a big exception 
because it's maintained pretty much out of tree.

Not so much of an issue this time around, but I don't think new drivers or 
rewrites (even if they are reasonably separate) should be going in a late -rc 
kernel.

Just my two pence.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
