Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWBPWdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWBPWdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWBPWdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:33:12 -0500
Received: from smtp.enter.net ([216.193.128.24]:19717 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750758AbWBPWdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:33:12 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 16 Feb 2006 17:42:25 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner>
In-Reply-To: <43F4BF26.nail2KA210T4X@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602161742.26419.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 February 2006 13:06, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > > I usually fix real bugs immediately after I know them.
> >
> > "Usually" is the key here. Sometimes, you refuse to fix real bugs
> > forever even if you're made aware of them, and rather shift the blame
> > on somebody else.
>
> Show me a single real bug that I did not fix.

At this point I, personally, am not aware of any.  However, after a careful 
review of libscg in preparation for the patch I promised you, I can see that 
it would be possible for the code to be rewritten so that just the linux 
section contains the various workarounds that might be needed.

With your refusal to even consider doing that I can see where some people get 
this idea (I myself was under this exact same belief until I began my code 
review in preparation for the proposed patch).

I am unsure if you refused to provide OS specific workarounds for known bugs 
in order to keep the code orthogonal,  or if you had another reason. But with 
the division of the various operating system specific pieces of libscg into 
seperate source files it doesn't make sense.

> > > I don't see that it makes sense to archive Linux bugs as long ad the
> > > Linux kernel folks are obviously not willing to fix them.
> >
> > Then the bugs can't have been important to you.
>
> ??? Id the Linux kernel is not fixed, the importance is irrelevent
> unfortunately.

Of the two bugs you've reported, one only exists in a deprecated and soon to 
be removed module. I will try to fix the other one as soon as you can provide 
me with enough data that I can see exactly what is getting messed up where.

As to you wanting to be able to read the SCSI status byte and the actual size 
of the completed DMA... Those parts of the kernel are as close to a blackbox 
to me as any code gets. Perhaps you could provide information or ideas on how 
it could be managed?

DRH
