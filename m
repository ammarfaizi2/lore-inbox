Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUFINmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUFINmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUFINmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:42:20 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:17386 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263663AbUFINmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:42:18 -0400
Date: Wed, 9 Jun 2004 09:43:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
In-Reply-To: <20040609133653.GH1444@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0406090942420.1838@montezuma.fsmlabs.com>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr>
 <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com>
 <20040609133653.GH1444@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, William Lee Irwin III wrote:

> On Wed, 9 Jun 2004, Eric BEGOT wrote:
> >> I've installed 2.6.7-rc3-mm1 patch on my x86 and during the boot it
> >> freezes. The last messages are :
> >> CPU0: AMD Athlon(tm) XP 2400+ stepping 01
> >> per-CPU timeslice cutoff : 731,38 usecs
> >> task migration cache decay timeout : 1 msecs.
> >> enabled ExtINT on CPU#0
> >> ESR value before enabling vector : 00000000
> >> ESR value after enabling vector : 00000000
> >> Booting processor 1/15 eip 3000
>
> On Wed, Jun 09, 2004 at 09:13:03AM -0400, Zwane Mwaikambo wrote:
> > Try backing out this patch first;
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/broken-out/apic-enumeration-fixes.patch
> > The other suspect would be the cpumask patch, but that may be a bit
> > harder to backout.
>
> As curious as I am as to whether that works, I'm also curious as to
> whether it's the culprit in this case. Eric, could you also describe your
> system? A dmesg from a working kernel would also help.

I'm leaning more towards the cpumask stuff but at least eliminating your
patch being a culprit gets us further.

	Zwane

