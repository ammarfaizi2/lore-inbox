Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbTBRLas>; Tue, 18 Feb 2003 06:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbTBRLas>; Tue, 18 Feb 2003 06:30:48 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:64704 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S267748AbTBRLar>;
	Tue, 18 Feb 2003 06:30:47 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] contest v0.61 benchmark
Date: Tue, 18 Feb 2003 22:40:34 +1100
User-Agent: KMail/1.5
Cc: Cliff White <cliffw@osdl.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Bill Davidsen <davidsen@tmr.com>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302182240.34315.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Contest is a system responsiveness benchmark for kernel development looking at
fair scheduling.

It can be found here:
http://contest.kolivas.org

Changes since the last release:
Lots of little bugfixes mainly
Increased resolution of read and io loads
Added io_other load
Corrected dbench_load to dbench num_cpus*16
More detailed instructions
Man Page update

This version will give different results to previous versions of contest so to
upgrade please delete all the .log files in your testbed directory. 

Known Bugs:
Contest will still run each kernel compilation if the load fails to initialise
(eg dbench doesnt start) and so please ensure all the necessary load 
applications are in your PATH.
io_other needs the -o parameter to know where to dump it's io load or else it 
will be no load

If your load times are the same as your no_load times then the load has failed 
to initialise.

Con
