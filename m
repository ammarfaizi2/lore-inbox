Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbTCWUT5>; Sun, 23 Mar 2003 15:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbTCWUT5>; Sun, 23 Mar 2003 15:19:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46011 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263178AbTCWUT4>; Sun, 23 Mar 2003 15:19:56 -0500
Date: Sun, 23 Mar 2003 12:30:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>
cc: Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <402760000.1048451441@[10.10.2.4]>
In-Reply-To: <1048450211.1486.19.camel@phantasy.awol.org>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But if you assume this, what are the official releases for anyway?
> 
> Well, official releases have always been sort of arbitrary for the
> kernel... just labeled releases along the course of development. 
> Although with the recent addition of the -rc patches, they tend to
> ensure the latest round of development at least resulted in a stable
> release.  But look at all the major vendors - their 2.4.18 release, for
> example, may include whatever the latest pre-patch was at the time.

I don't agree that's always been true by any means. It may currently
be true, but that's far from a good thing. The current state of divergance
the distros have from mainline 2.4 is IMHO the biggest problem Linux has
today.

The distros inherently have a conflict of interest getting changes merged
back into mainline ... it's time consuming to do, it provides them no real
benefit (they have to maintain their huge trees anyway), and it actively
damages the "value add" they provide.
 
> Anyhow, to answer your question: the official releases are labels along
> the course of development for use by vendors, developers, and users who
> (as Alan described) can manage their own kernels.
> 
> Do not get me wrong, I think users can and should compile their own
> kernel if they want.  And as kernel developers, we should facilitate
> that.  But if someone requires handholding and instant or controlled
> releases of bug fixes, they either need to be able to rely on their own
> ability to get them or their vendor.  We have vendors for a reason,
> after all.

If that's people's attitude ("you should use a vendor"), then we need a 
2.4-fixed tree to be run by somebody with an interest in providing 
critical bugfixes to the community with no distro ties. People may be
perfectly capable of finding, applying, and collecting their own patches,
but that's no reason to make it difficult.

M.

