Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750714AbWFEWl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFEWl5 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWFEWl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:41:57 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:24566 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750714AbWFEWl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:41:56 -0400
Message-Id: <20060605222956.608067000@localhost.localdomain>
Date: Mon, 05 Jun 2006 15:29:56 -0700
From: dsaxena@plexity.net
To: mingo@elte.hu, tglx@linutronix.de, johnstul@us.ibm.com
Cc: dwalker@mvista.com, james.perkins@windriver.com,
        linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, khilman@mvista.com
Subject: [patch-rt 0/2] Initial ARM generic-timeofday support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset (against -rt26, but should apply to newer patch) adds
initial support for generic TOD on ARM. It is fairly simple and
copletely rips out the existing TOD code in ARM, assuming that each
sub-arch will either provide a clocksource or enable CONFIG_IS_TICK_BASED.
Currently only Versatile is supported.

Please apply so folks can start testing or provide comments.

Tnx,
~Deepak

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
