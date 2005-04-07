Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVDGT4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVDGT4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVDGT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:56:06 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39063 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262579AbVDGT4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:56:02 -0400
Date: Thu, 7 Apr 2005 21:56:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Phillips <phillips@istop.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407195625.GA9439@mars.ravnborg.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <16980.55403.190197.751840@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org> <200504071300.51907.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504071300.51907.phillips@istop.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 01:00:51PM -0400, Daniel Phillips wrote:
> On Thursday 07 April 2005 11:10, Linus Torvalds wrote:
> > On Thu, 7 Apr 2005, Paul Mackerras wrote:
> > > Do you have it automated to the point where processing emailed patches
> > > involves little more overhead than doing a bk pull?
> >
> > It's more overhead, but not a lot. Especially nice numbered sequences like
> > Andrew sends (where I don't have to manually try to get the dependencies
> > right by trying to figure them out and hope I'm right, but instead just
> > sort by Subject: line)...
> 
> Hi Linus,
> 
> In that case, a nice refinement is to put the sequence number at the end of 
> the subject line so patch sequences don't interleave:
> 
>    Subject: [PATCH] Unbork OOM Killer (1 of 3)
>    Subject: [PATCH] Unbork OOM Killer (2 of 3)
>    Subject: [PATCH] Unbork OOM Killer (3 of 3)
>    Subject: [PATCH] Unbork OOM Killer (v2, 1 of 3)
>    Subject: [PATCH] Unbork OOM Killer (v2, 2 of 3)

This breaks the rule of a descriptive subject for each patch.
Consider 30 subjetcs telling you "Subject: PCI updates [001/030]
That is not good.

	Sam
