Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVCCJS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVCCJS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCCJR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:17:58 -0500
Received: from aun.it.uu.se ([130.238.12.36]:29416 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261733AbVCCJOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:14:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.54647.354607.902748@alkaid.it.uu.se>
Date: Thu, 3 Mar 2005 10:14:31 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [request for inclusion] Filesystem in Userspace
In-Reply-To: <20050302123123.3d528d05.akpm@osdl.org>
References: <E1D6YPJ-0000Jv-00@dorka.pomaz.szeredi.hu>
	<20050302123123.3d528d05.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Miklos Szeredi <miklos@szeredi.hu> wrote:
 > >
 > > Do you have any objections to merging FUSE in mainline kernel?
 > 
 > I was planning on sending FUSE into Linus in a week or two.  That and
 > cpusets are the notable features which are 2.6.12 candidates.
 > 
 > - crashdump seems permanently not-quite-ready
 > 
 > - perfctr works fine, but is rather deadlocked because it is
 >   similar-to-but-different-from ia64's perfmon, and might not be suitable
 >   for ppc64 (although things have gone quiet on the latter front).

perfctr has one API update pending, and then the API should be
in it final-ish form. David Gibson at IBM has done a ppc64 port,
which is about ready to be merged, and someone else has just
started working on a mips port.

/Mikael
