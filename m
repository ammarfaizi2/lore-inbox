Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbTJPUdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbTJPUdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:33:51 -0400
Received: from tantale.fifi.org ([216.27.190.146]:17055 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S263174AbTJPUdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:33:49 -0400
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org,
       Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Subject: Re: LVM Snapshots
References: <20031015174017.606c6047.Christoph.Pleger@uni-dortmund.de>
	<200310151751.23103.m.c.p@wolk-project.de>
	<87n0c2wih5.fsf@ceramic.fifi.org>
	<200310161128.23235.m.c.p@wolk-project.de>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 16 Oct 2003 13:33:43 -0700
In-Reply-To: <200310161128.23235.m.c.p@wolk-project.de>
Message-ID: <87ismo6hy0.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

> On Wednesday 15 October 2003 18:53, Philippe Troin wrote:
> 
> Hi Philippe,
> 
> > Marc-Christian Petersen <m.c.p@wolk-project.de> writes:
> > > On Wednesday 15 October 2003 17:40, Christoph Pleger wrote:
> > >
> > > Hi Christoph,
> > >
> > > > I am using a 2.4.22 kernel from www.kernel.org together with an XFS
> > > > patch from SGI. I want to use LVM for creating snapshots for backups,
> > > > but I found out that I cannot mount the snapshots of journalling
> > > > filesystems (EXT3, XFS, Reiser). Only JFS snapshots can be mounted.
> > > > My research on internet gave the result that a kernel-patch must be
> > > > used to solve that problem, but I could not find such a patch for Linux
> > > > 2.4.22, so where can I get it?
> > >
> > > Marcelo decided not to apply that needed patch. Here it is for you to
> > > play with :) ... It'll apply with offsets to 2.4.23-pre7.
> >
> > What was the reason? I cannot find this thread in the archives...
> 
> it was a private mail. Pasting relevant stuff:
> 
> ---------------------------------------------------------------------
> > - [PATCH 2.4.23-pre1] LVM 1.0.7 ADDON: Allow snapshots on journaling
> >                                        filesystems
> 
> LVM has already been updated on 2.4.23-pre. Lets do more changes later on.
> 
> ---------------------------------------------------------------------

Nothing technical then, Marcelo is just being slow for stability's
sake and easier testing. I guess that will go in somewhere in a later
23-pre or in 24.

Thanks for the info.

Phil.
