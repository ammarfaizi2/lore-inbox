Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbSLLDf4>; Wed, 11 Dec 2002 22:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbSLLDf4>; Wed, 11 Dec 2002 22:35:56 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:49682 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267408AbSLLDfz>;
	Wed, 11 Dec 2002 22:35:55 -0500
Date: Wed, 11 Dec 2002 22:43:38 -0500 (EST)
Message-Id: <200212120343.gBC3hcO11146@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Changes doc update.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Jones writes:

> - Alternatively, the procps by Albert Cahalan now supports the
>   altered formats since v3.0.5, but lags behind the bleeding edge
>   version maintained by Rik and Robert. -- http://procps.sf.net/

Currently I'd say it's mostly the other way around.

Differences between procps-2.1.11 and procps-3.1.2 that relate
to Linux 2.5.xx support are:

1. Robert has /proc/*/wchan support (for WCHAN w/o System.map)
2. My vmstat has a fast O(1) algorithm for 2.5.xx kernels
3. My vmstat reports IO-wait time
4. My sysctl handles the 2.5.xx VLAN interfaces

So that's 1-to-3 in my favor, based strictly on support of the
2.5.xx kernels. I find this odd actually, seeing as the procps-2
developers made #2 and #3 possible. The only time I fell behind
was when Rik patched procps _before_ Linus accepted a change.



