Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268371AbTAMXT0>; Mon, 13 Jan 2003 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268393AbTAMXT0>; Mon, 13 Jan 2003 18:19:26 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:33180 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S268371AbTAMXTZ>;
	Mon, 13 Jan 2003 18:19:25 -0500
Message-ID: <1042500483.3e234b8335def@kolivas.net>
Date: Tue, 14 Jan 2003 10:28:03 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Cliff White <cliffw@osdl.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Bill Davidsen <davidsen@tmr.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Randy Hron <rwhron@earthlink.net>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
Subject: [ANNOUNCE] contest benchmark v0.60
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Contest is a system responsiveness benchmark for kernel development looking at
fair scheduling.

It can be found here:
http://contest.kolivas.net

Aggelos Economopoulos has completed a massive rewrite of the contest benchmark
in c to remove all BASH scripts and this will form the codebase for further
versions of contest.

Changes since the last release:
Complete change in the codebase, consolidation into one executable.
FreeBSD compatibility
Different format of the logs etc.
Addition of cacherun and dbench_loads
Rewrite of process_load by Rene Herman
More detailed instructions
Man Page
Lots of internal changes

This version will give different results to previous versions of contest so to
upgrade please delete all the .log files in your testbed directory. 

Known Bugs:
Contest will still run each kernel compilation if the load fails to initialise
(eg dbench doesnt start) so please ensure all the necessary load applications
are in your PATH
Other minor annoyances

Aggelos is the main coder now but I am still the official maintainer so please
direct all bug reports, comments, patches etc to me. Further releases are
planned in the near future with minor changes, but results obtained from contest
should be compatible with this version.
 
Con
