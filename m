Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTLRXwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265408AbTLRXwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:52:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21977
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265406AbTLRXwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:52:08 -0500
Date: Fri, 19 Dec 2003 00:52:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Joe Pranevich <jpranevich@kniggit.net>, linux-kernel@vger.kernel.org
Subject: Re: Wonderful World of Linux 2.6 - Final
Message-ID: <20031218235211.GD10250@dualathlon.random>
References: <1071724386.2820.12.camel@localhost.localdomain> <200312180929.46723.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312180929.46723.habanero@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 09:29:46AM -0600, Andrew Theurer wrote:
> be scheduled optimally, for example, a kernel compile with -j4 on a 4-way P4, 
> with and without HT:
> 
> average of 10 kernel compiles with -j4 on 2.6.0-test9:
> 
> HT disabled: Elapsed: 145.086s User: 513.808s System: 44.724s CPU: 384.5%
> HT enabled: Elapsed: 172.463s User: 633.856s System: 48.003s CPU: 394.8%

is that 4-way a 4-logical-way or 4-physical-way? If it's a 4-logical
way, this workload is much closer to the best case than the worst case.
I'm guessing a simple -j2 or -j3 should do much worse than that.
