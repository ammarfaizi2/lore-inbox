Return-Path: <linux-kernel-owner+w=401wt.eu-S1426019AbWLHRMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426019AbWLHRMc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426028AbWLHRMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:12:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:45437 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426019AbWLHRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:12:31 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 18:12:19 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Suresh Siddha <suresh.b.siddha@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>, Ingo Molnar <mingo@elte.hu>
References: <200612080401.25746.ak@suse.de> <20061208020804.c5e5e176.akpm@osdl.org>
In-Reply-To: <20061208020804.c5e5e176.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081812.19933.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My old 4-way Intel Nocona-based SDV panics during boot with "APIC mode must
> be flat on this system" and I don't know how to make it stop.  Help.

Hmm, i had these patches for week and didn't change anything. Weird.
> 
> It didn't do this with your tree in 2.6.19-rc6-mm1 or 2.6.19-rc6-mm2, both
> of which included
> x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch.  It still
> reverts cleanly, so there might be something else in -mm (apart from
> revert-x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch ;))
> which fixes it up.

I'll investigate.

> Also, we weren't supposed to merge that patch at all.  It is supposedly
> obsoleted by Ingo's new genapic work.

I decided to skip that because it was still far too fresh and i also
didn't have time yet to review it closely.

-Andi
 
