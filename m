Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263200AbTCWUne>; Sun, 23 Mar 2003 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbTCWUne>; Sun, 23 Mar 2003 15:43:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:5381
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263200AbTCWUnc>; Sun, 23 Mar 2003 15:43:32 -0500
Subject: Re: Ptrace hole / Linux 2.2.25
From: Robert Love <rml@tech9.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Martin Mares <mj@ucw.cz>, Alan Cox <alan@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <402760000.1048451441@[10.10.2.4]>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	 <1048448838.1486.12.camel@phantasy.awol.org>
	 <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
	 <1048450211.1486.19.camel@phantasy.awol.org>
	 <402760000.1048451441@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1048452882.1486.58.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2003 15:54:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 15:30, Martin J. Bligh wrote:

> I don't agree that's always been true by any means. It may currently
> be true, but that's far from a good thing. The current state of divergance
> the distros have from mainline 2.4 is IMHO the biggest problem Linux has
> today.

What part of my statement are you disagreeing with, here?

I agree distribution divergence is a big issue.  It may be a mostly
insolvable one, too.  It is partially a result of having a long
development cycle.  But even if we had a shorter development cycle,
different distributions have different priorities.  It is a hard
problem.

> The distros inherently have a conflict of interest getting changes merged
> back into mainline ... it's time consuming to do, it provides them no real
> benefit (they have to maintain their huge trees anyway), and it actively
> damages the "value add" they provide.

I do not disagree.

Although, I think there is incentive to get work merged.  It _does_
reduce maintenance.  I think you can see Red Hat merging stuff back.  I
know my employer encourages everything I do to be done openly and get it
merged.  Its a huge benefit to maintenance and QA to get stuff merged.

> If that's people's attitude ("you should use a vendor"), then we need a 
> 2.4-fixed tree to be run by somebody with an interest in providing 
> critical bugfixes to the community with no distro ties. People may be
> perfectly capable of finding, applying, and collecting their own patches,
> but that's no reason to make it difficult.

No where above did I say "you should use a vendor"

In fact, what I did say is "I think users can and should compile their
own kernel if they want.  And as kernel developers, we should facilitate
that."

I merely suggest that users should not expect anything if they go it
there own.  They need to follow the lists and be informed.  Its like me
assuming I can maintain my car without a mechanic and then freaking out
when I did not hear about a service defect.  Actually, a better analogy
may include me knowing nothing about cars, too :)

Marcelo is in a tough spot.  I think Arjan's email (just sent) sums it
up well.  It is not so clear cut.  Personally, I think the ext3 bugs in
2.4.20 are worse than this local ptrace problem (there are other local
issues, too).  I also think some people are skeptical over the
correctness of this patch.

Anyhow, what exactly are we arguing over?

	Robert Love

