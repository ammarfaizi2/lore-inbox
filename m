Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTH3DW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 23:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbTH3DW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 23:22:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:41188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262830AbTH3DWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 23:22:15 -0400
Message-Id: <200308300322.h7U3MD324122@mail.osdl.org>
To: akpm@osdl.org, linstab@lists.osdl.org
cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4-mm3-1 - osdl-aim-7 
Date: Fri, 29 Aug 2003 20:22:13 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry this is taking so long,
but we now have some results.
http://developer.osdl.org/cliffw/reaim/index.html for all details
More test should be completing as i type this.

1-cpu
STP id	PLM#	Kernel Name 	Workfile    MaxJPM MaxUser Change
278562	2079	2.6.0-test4-mm3-1 new_dbase 989.02 17	   0.00
278000	2067	linux-2.6.0-test4 new_dbase 990.15 17	   0.11

4-cpu
STP id	PLM#	Kernel Name 	 Workfile MaxJPM  MaxUser Change
278623	2079	2.6.0-test4-mm3-1 compute 5162.20 84	  0.00
278030	2067	linux-2.6.0-test4 compute 5183.03 88	  0.40

8-cpu
STP id	PLM#	Kernel Name 	Workfile  MaxJPM  MaxUser Change
278567	2079	2.6.0-test4-mm3-1 compute 9694.24 160	  0.00
277982	2067	linux-2.6.0-test4 compute 9432.60 160	 -2.70


Worth Noting: rough 2.4 comparison, from recent runs
STP id  PLM#    Kernel Name       Workfile  MaxJPM  MaxUser
1-cpu
278409	2075	patch-2.4.23-pre1 new_dbase 1030.64  18
4-cpu
278166	2069	patch-2.4.22-rc4 compute    5468.46  88
8-cpu
278255	2072	linux-2.4.22 	compute     9976.95 152



cliffw

