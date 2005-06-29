Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVF2G2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVF2G2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVF2G2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:28:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262443AbVF2G2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:28:50 -0400
Date: Tue, 28 Jun 2005 23:30:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.13-rc1
Message-ID: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, guys,
 there was a lot of stuff pending after 2.6.12, and in the week and a half
since the release, the current diff against it has grown to almost three
megabytes compressed.

Which is actually normal for a -rc1 release judging by the two last ones,
but it usually takes us longer than ten days to get there. Which just
shows that 2.6.12 was brewing for too long, but we can also think
positively and say that perhaps it also seems to imply that this git thing
is working out and not slowing people down.

Anyway, I really don't want to drag out 2.6.13 as long as 2.6.12 took, and
we don't have any reason to anyway, so let's try to see if we can calm
things down again, and people who are thinking about writing new code
might think about spending some quality time looking at the existing code
and patches instead.

Now, that big patch ends up being spread out over 2069 commits, and a
noticeable chunk of it is actually the new xtensa architecture that got
merged, but that still leaves a lot of patches all over the place (things
like a few new console fonts, for example ;). The shortlog is over 100kB
in size, which means that I think linux-kernel won't take it if I include
it here, so I won't.  Similarly, the diffstat is 200kB, partly because of 
the spread out nature of the pacthes.

ARM, x86[-64], ppc, sparc updates, networking, sound, infiniband, input
layer, ISDN, MD, DVB, V4L, network drivers, pcmcia, isofs, jfs, nfs,
xfs, knfsd.. You name it.

Git trees and traditional patches/tar-balls are out there, or at least 
slowly mirroring out. Go wild,

		Linus
