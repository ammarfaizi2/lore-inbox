Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWCANji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWCANji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWCANji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:39:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750911AbWCANjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:39:37 -0500
Date: Wed, 1 Mar 2006 08:39:13 -0500
From: Dave Jones <davej@redhat.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Michael Ellerman <michael@ellerman.id.au>,
       "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060301133913.GB16840@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Michael Ellerman <michael@ellerman.id.au>,
	"Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org,
	Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <Pine.LNX.4.64.0602282234120.28074@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602282234120.28074@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 10:36:09PM -0800, Zwane Mwaikambo wrote:

 > > The number of systems that actually *need* APIC enabled are in the
 > > vast (though growing) minority, so it's unlikely that most newbies
 > > will hit this.  The problem is also the inverse of what you describe.
 > > Typically the distros have DMI lists of machines that *need* APIC
 > > to make it enabled by default so everything 'just works'.
 > > 
 > > The big problem the patch solves is allowing it to be possible
 > > to build a kernel with UP APIC code, but disabled by default
 > > (Because there a lot of older machines that die horribly if it
 > >  was enabled by default).
 > 
 > The current policy is off if it was disabled by the BIOS. Is the intention 
 > of this patch to have it off unconditionally unless explicitely enabled by 
 > kernel parameter?

Yes, (or forced on by dmi string)

		Dave


