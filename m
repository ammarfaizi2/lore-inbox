Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272635AbRIGM4c>; Fri, 7 Sep 2001 08:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272634AbRIGM4W>; Fri, 7 Sep 2001 08:56:22 -0400
Received: from kaboom.dsl.xmission.com ([166.70.14.108]:10027 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id <S272633AbRIGM4L>;
	Fri, 7 Sep 2001 08:56:11 -0400
Date: Fri, 7 Sep 2001 06:56:26 -0600 (MDT)
From: Chris Ricker <kaboom@gatech.edu>
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: Robert Love <rml@tech9.net>
Cc: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other
 patches
In-Reply-To: <999840042.1164.14.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109070635220.26784-100000@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Sep 2001, Robert Love wrote:

> On Fri, 2001-09-07 at 01:19, Daniel Phillips wrote:
> > The other Unices are at least evenly split, or mostly preemptible.
> > Typically, a more complex strategy is used where spinlocks can sleep
> > after a few spins.  This patch is very conservative in that regard,
> > it basically just uses the structure we already have, SMP spinlocks.
> 
> I did not know other Unices were (in general) preemptible.  Solaris is?
> The only one I thought was preemptible was Irix.

Solaris is, and has been since good ol' Solaris 2.0.  So's AIX and even more
obscure things like DG/UX.  I'd think all SysVR4 derivatives have to be, by
virtue of the SysV schedular (threads have priorities from 0 to 159; system
threads run from 60 to 99, so the schedular must be able to preempt system 
threads for the real-time threads from 100 to 159).

later,
chris

-- 
Chris Ricker                                               kaboom@gatech.edu
                                                          chris@gurulabs.com

