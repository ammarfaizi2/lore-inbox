Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUCFOzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 09:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUCFOzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 09:55:13 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:9486 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261677AbUCFOzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 09:55:10 -0500
Date: Sat, 6 Mar 2004 09:55:09 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0403041415400.195051-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0403060952000.393748-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Mar 2004, Ron Peterson wrote:

> ... thought I'd report that I installed 2.4.21 on a single processor
> about a week ago (1GHz PIII, 500MB, Intel 82820 (ICH2) Chipset w/
> eepro100 module), and am seeing the same bad behaviour.

I've booted with kernel profiling turned on.  I've posted some preliminary
results.  I don't have profile data yet, but you can see in the following
that when I turn off my iptables rules, the ping latency graph flattens
out.

http://depot.mtholyoke.edu:8080/tmp/tap-sam/2004-03-06_9:30/sam_last_108000.png
http://depot.mtholyoke.edu:8080/tmp/tap-sam/

My understanding is that the kernel profile information will become
interesting when the machine starts thrashing.  If it would be useful for
me to dump anything before then, let me know.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

