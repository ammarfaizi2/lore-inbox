Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUFINh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUFINh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUFINh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:37:28 -0400
Received: from holomorphy.com ([207.189.100.168]:35204 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263663AbUFINhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:37:15 -0400
Date: Wed, 9 Jun 2004 06:36:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609133653.GH1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@fsmlabs.com>,
	Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr> <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, Eric BEGOT wrote:
>> I've installed 2.6.7-rc3-mm1 patch on my x86 and during the boot it
>> freezes. The last messages are :
>> CPU0: AMD Athlon(tm) XP 2400+ stepping 01
>> per-CPU timeslice cutoff : 731,38 usecs
>> task migration cache decay timeout : 1 msecs.
>> enabled ExtINT on CPU#0
>> ESR value before enabling vector : 00000000
>> ESR value after enabling vector : 00000000
>> Booting processor 1/15 eip 3000

On Wed, Jun 09, 2004 at 09:13:03AM -0400, Zwane Mwaikambo wrote:
> Try backing out this patch first;
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/broken-out/apic-enumeration-fixes.patch
> The other suspect would be the cpumask patch, but that may be a bit
> harder to backout.

As curious as I am as to whether that works, I'm also curious as to
whether it's the culprit in this case. Eric, could you also describe your
system? A dmesg from a working kernel would also help.

-- wli
