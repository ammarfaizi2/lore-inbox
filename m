Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUFINWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUFINWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUFINMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:12:25 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:42982 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265776AbUFINLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:11:37 -0400
Date: Wed, 9 Jun 2004 09:13:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Eric BEGOT <eric_begot@yahoo.fr>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
In-Reply-To: <40C6F3C3.9040401@yahoo.fr>
Message-ID: <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, Eric BEGOT wrote:

> I've installed 2.6.7-rc3-mm1 patch on my x86 and during the boot it
> freezes. The last messages are :
>
> CPU0: AMD Athlon(tm) XP 2400+ stepping 01
> per-CPU timeslice cutoff : 731,38 usecs
> task migration cache decay timeout : 1 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector : 00000000
> ESR value after enabling vector : 00000000
> Booting processor 1/15 eip 3000

Try backing out this patch first;

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/broken-out/apic-enumeration-fixes.patch

The other suspect would be the cpumask patch, but that may be a bit
harder to backout.

	Zwane
