Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVFUVKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVFUVKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVFUVHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:07:51 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62340 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262321AbVFUU4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:56:48 -0400
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: -mm -> 2.6.13 merge status 
In-reply-to: Your message of Tue, 21 Jun 2005 13:22:04 PDT.
             <20050621132204.1b57b6ba.akpm@osdl.org> 
Date: Tue, 21 Jun 2005 13:56:11 -0700
Message-Id: <E1Dkpn1-0006va-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Jun 2005 13:22:04 PDT, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > > kexec and kdump
> > > 
> > >     I guess we should merge these.
> > > 
> > >     I'm still concerned that the various device shutdown problems will
> > >     mean that the success rate for crashing kernels is not high enough for
> > >     kdump to be considered a success.  In which case in six months time we'll
> > >     hear rumours about vendors shipping wholly different crashdump
> > >     implementations, which would be quite bad.
> > > 
> > >     But I think this has gone as far as it can go in -mm, so it's a bit of
> > >     a punt.
> > 
> > I'm not particularly pleased with these,
> 
> How come?
> 
> > and indeed vendors ARE shipping 
> > other crashdump methods.
> 
> Which ones?

And which ones that __WORK__?  We have a few customers out there from
both distros and all the crash dump methods that I've seen fail either
ALWAYS or ALMOST ALWAYS on customer sites.  And yes, we hear about them
and I believe that our partners understand the pain that this causes
us and our customers.

Kexec/kdump has a chance of working reliably.  The others are complete
crap.

gerrit
