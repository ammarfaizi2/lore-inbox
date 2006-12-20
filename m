Return-Path: <linux-kernel-owner+w=401wt.eu-S1030328AbWLTTsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWLTTsF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWLTTsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:48:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37094 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030314AbWLTTsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:48:03 -0500
Subject: Re: [PATCH 0/5][time][x86_64] GENERIC_TIME patchset for x86_64
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
In-Reply-To: <200612201926.kBKJQoqN020967@turing-police.cc.vt.edu>
References: <20061220011707.25341.6522.sendpatchset@localhost>
	 <200612201926.kBKJQoqN020967@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 11:47:57 -0800
Message-Id: <1166644078.5996.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 14:26 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 19 Dec 2006 20:20:39 EST, john stultz said:
> > 	I didn't hear any objections (or really, any comments) on my
> > last release, so as I mentioned then, I want to go ahead and push this
> > to Andrew for a bit of testing in -mm. Hopefully targeting for
> > inclusion in 2.6.21 or 2.6.22.
> 
> Am running it on a Dell Latitude D820 (Core2 T7200 cpu).  I had to un-do
> 4 conflicting patches in -rc1-mm1 and then it applied and ran clean, I still
> need to look at re-merging them:

Doh. Oh right, I should have checked against -mm for conflicts.

> hpet-avoid-warning-message-livelock.patch
> clockevents-i386-hpet-driver.patch
> get-rid-of-arch_have_xtime_lock.patch
> x86_64-mm-amd-tsc-sync.patch
> 
> It *looks* like all the pieces are there except a few lines of Kconfig
> magic to wire up the dynticks/NO_HZ stuff - or did I miss something crucial?

Yea, I will rework the patches ontop of -mm.

thanks
-john


