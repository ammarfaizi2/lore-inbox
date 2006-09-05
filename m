Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWIEAC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWIEAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 20:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWIEAC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 20:02:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42897 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964932AbWIEACZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 20:02:25 -0400
Date: Mon, 4 Sep 2006 17:02:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: davem@davemloft.net
cc: linux-kernel@vger.kernel.org
Subject: AIM7 fails with 2.6.18-rc5-mm1
Message-ID: <Pine.LNX.4.64.0609041701280.927@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an 8p Altix. 6 GB Ram

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1     2435.06  100      2435.0649      2.46      0.02   Mon Sep  4 
10:17:44 2006
  100   178784.27   94      1787.8427      3.36      7.08   Mon Sep  4 
10:17:58 2006
  200   280636.11   95      1403.1805      4.28     14.46   Mon Sep  4 
10:18:15 2006
  300   340973.67   91      1136.5789      5.28     22.35   Mon Sep  4 
10:18:37 2006
  400   382897.26   82       957.2431      6.27     30.44   Mon Sep  4 
10:19:03 2006
  500   413793.10   86       827.5862      7.25     38.14   Mon Sep  4 
10:19:33 2006
  600   434940.20   89       724.9003      8.28     46.43   Mon Sep  4 
10:20:07 2006
  700
Fatal error 98 at line 284 of file pipe_test.c: bind on write -- Address 
already in use

Child #489: : Address already in use

Failed to execute
        udp_test 100

Fatal error 98 at line 264 of file pipe_test.c: bind on write -- Address 
already in use

Child #286: : Address already in use

Failed to execute
        udp_test 100

etc etc

Is this a known issue?

