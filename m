Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbSIRQMw>; Wed, 18 Sep 2002 12:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbSIRQMw>; Wed, 18 Sep 2002 12:12:52 -0400
Received: from host194.steeleye.com ([66.206.164.34]:46866 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267239AbSIRQMt>; Wed, 18 Sep 2002 12:12:49 -0400
Message-Id: <200209181617.g8IGHgp03871@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [2.5] DAC960
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Sep 2002 11:17:42 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Linus indicated at the Kernel Summit that he'd like to see a
> > > cleaned-up scsi midlayer used as framework for *all* disk IO,
> > > including IDE.  Obviously, what with IDE transitions and whatnot, we
> > > are far from being ready to attempt that, so see "nursing along"
> > > above.  There's no longer any chance that a generic disk midlayer is
> > > going to happen in this cycle, as far as I can see.  Still, anybody
> > > who is interested would do well by studing the issues, and fixing
> > > broken drivers certainly qualifies as a way to come up to speed.
> > > First of all, I believe Linus' plan is to push more functionality into
> > the block layer.
>
> I distinctly heard him say he wanted the scsi mid layer repurposed as
> an interface for all disks.  Maybe he changed his mind?

I don't recall hearing this.  I remember his agreeing with the idea of 
slimming down the SCSI mid layer, which does rather contradict the use SCSI 
for everything approach.

After the Kernel Summit, there was quite a long thread on l-k with Joerg 
Schilling on exactly this issue.  The upshot of which was I clearly said we 
weren't going to go the SCSI is everything route.  Unless there's any reason 
to change course, I think that's the current plan.

James


