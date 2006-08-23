Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWHWNtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWHWNtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHWNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:49:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:13973 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932272AbWHWNtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:49:04 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Date: Wed, 23 Aug 2006 15:44:26 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <200608231429.04413.ak@suse.de> <20060823125843.GF697@frankl.hpl.hp.com>
In-Reply-To: <20060823125843.GF697@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231544.26756.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If they have variations it could be with
> the low power (laptop) models where counters may not be present at all.

It would surprise me if they ever released anything again with no counters.

It's mainly simulators where the counters are missing (e.g. SimNow is a pretty 
accurate simulation otherwise, but doesn't have performance counters)

> 
> > Perhaps add a force argument again that disables the family check too.
> > 
> > > Ok, I think I understand now:
> > > 	1/ Bios and Kernel Developer Guide from Ahtlon64 and Opteron 64 is
> > > 	  what you are talking about with K7/K8
> > 
> > Well K8.
> > 
> > K7 has a different one. But ok. I think you don't try to support K7 at all
> > currently (it has the same register format as K8, but the list of counters
> > is different)
> > 
> What is the "commercial name" of K7 processors?

Athlon/Athlon XP/Athlon MP/Sempron (early models, later are K8)/Duron and some
of the Geodes are K7 based too.

-Andi
