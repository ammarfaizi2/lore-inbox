Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264135AbTEORhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTEORhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:37:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48603 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264135AbTEORhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:37:47 -0400
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       keith maanthey <kmannth@us.ibm.com>
In-Reply-To: <20030515172855.GA10831@Wotan.suse.de>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com>
	 <20030515065120.GA3469@Wotan.suse.de>
	 <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com>
	 <20030515172855.GA10831@Wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 May 2003 10:46:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 10:28, Andi Kleen wrote:
> > You did get around it in the generic subarch (which I love, by the way,
> > thanks so much for doing that work), but in a roundabout way. (via
> > #ifdef APIC_DEFINITION trickery). 
> 
> The best fix is probably to just remove the summit selection and replace
> it with the generic architecture.

I'd agree (long term even more strongly), although along with that I'd
like to be able to pick and choose my subarch. So I can have a kernel
that supports say, PC and BigSMP, but not NUMAQ or whatever. I believe
this is doable with your infrastructure, but I'm not sure how much work
it will take. 

And before we make any larger changes, I'd like to just get stuff
compiling first (Keith's apic patch landing about the same time and
broke generic, and generic broke summit so right now neither subarch
builds properly). 

thanks
-john




