Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbVKQAvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVKQAvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbVKQAvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:51:23 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:60167 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1161061AbVKQAvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:51:22 -0500
Message-ID: <437BD3FA.8060608@shadowen.org>
Date: Thu, 17 Nov 2005 00:51:06 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.15-rc1-git4 build failure on ppc64
References: <1132188084.24066.103.camel@localhost.localdomain>
In-Reply-To: <1132188084.24066.103.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:

> I get following compile error on PPC64 - while trying to compile
> CONFIG_FLATMEM=y. 
> 
> arch/powerpc/mm/numa.c: In function `dump_numa_topology':
> arch/powerpc/mm/numa.c:516: error: `SECTION_SIZE_BITS' undeclared (first
> use in this function)
> arch/powerpc/mm/numa.c:516: error: (Each undeclared identifier is
> reported only once
> arch/powerpc/mm/numa.c:516: error: for each function it appears in.)
> make[1]: *** [arch/powerpc/mm/numa.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/powerpc/mm] Error 2

Can you drop me a copy of your .config please.  I'll have a poke at it
in the morning.

-apw
