Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbTLRX53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbTLRX53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:57:29 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:28133 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265364AbTLRX51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:57:27 -0500
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Wonderful World of Linux 2.6 - Final
Date: Thu, 18 Dec 2003 17:58:55 -0600
User-Agent: KMail/1.5
Cc: Joe Pranevich <jpranevich@kniggit.net>, linux-kernel@vger.kernel.org
References: <1071724386.2820.12.camel@localhost.localdomain> <200312180929.46723.habanero@us.ibm.com> <20031218235211.GD10250@dualathlon.random>
In-Reply-To: <20031218235211.GD10250@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312181758.55059.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 December 2003 17:52, Andrea Arcangeli wrote:
> On Thu, Dec 18, 2003 at 09:29:46AM -0600, Andrew Theurer wrote:
> > be scheduled optimally, for example, a kernel compile with -j4 on a 4-way
> > P4, with and without HT:
> >
> > average of 10 kernel compiles with -j4 on 2.6.0-test9:
> >
> > HT disabled: Elapsed: 145.086s User: 513.808s System: 44.724s CPU: 384.5%
> > HT enabled: Elapsed: 172.463s User: 633.856s System: 48.003s CPU: 394.8%
>
> is that 4-way a 4-logical-way or 4-physical-way? If it's a 4-logical
> way, this workload is much closer to the best case than the worst case.
> I'm guessing a simple -j2 or -j3 should do much worse than that.

This is 4-way physical/4-way logical (no HT) vs 4-way physical/8-way logical 
(with HT)

