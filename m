Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWADKl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWADKl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWADKl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:41:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751237AbWADKl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:41:57 -0500
Date: Wed, 4 Jan 2006 02:41:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, george@mvista.com,
       zippel@linux-m68k.org, ulrich.windl@rz.uni-regensburg.de,
       tglx@linutronix.de
Subject: Re: [PATCH 8/11] Time: i386 Conversion - part 4: ACPI PM variable
 renaming and config change.
Message-Id: <20060104024113.73fe4266.akpm@osdl.org>
In-Reply-To: <1136370805.3788.19.camel@leatherman>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
	<20051216010802.19280.46938.sendpatchset@cog.beaverton.ibm.com>
	<20060103163554.48ce31a0.akpm@osdl.org>
	<1136370805.3788.19.camel@leatherman>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> > Anyway, I'll tenatively merge these patches into next -mm so they can get a
> > bit of testing.  Which causes a problem, because you don't then have a tree
> > against which to raise a new patch series.
> 
> I greatly appreciate the inclusion! I'm hoping a bit of time in -mm will
> shake out any remaining bugs. 
> 
> Although I'm not sure I understand what you mean about me not having a
> tree? Do you mean a public git tree? 
> 

Sorry.  I meant that once I've merged this series into -mm, you can no
longer generate a new patch series against -mm!  If I were to leave this
patch series out of next -mm, you'd have a clean tree to raise patches
against.

>
> > So perhaps it would be best if you were to
> > 
> > a) Tell me which patches to fold into which other patches to generate a
> >    series which compiles at every stage and
> > 
> > b) Send me a new set of changelogs for the resulting patch series.
> 
> I've got a set of chained git trees that store each patch, so its very
> easy to re-generate the changelog + patches after I've re-arranged them
> as you suggested.
> 
> Would a new patch-set to replace the current patchset be preferred here
> or do you just want the above?  

Replacement would be best.  If you can regenerate the diffs against
whatever tree you generated the last batch, that would work.

> Similarly, if we do run into bugs, would you prefer incremental fixup
> patches or cumulative replacement patches when a new release of the
> patchset is generated?

minimally-sized incremental fixes are preferred, please.

> I'm just getting back from vacation tonight, so I'll send whatever you
> prefer sometime tomorrow.

That would be good, thanks.

