Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268960AbTBSS3N>; Wed, 19 Feb 2003 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268961AbTBSS3N>; Wed, 19 Feb 2003 13:29:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2022 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268960AbTBSS3M>;
	Wed, 19 Feb 2003 13:29:12 -0500
Message-Id: <200302191839.h1JIdFT27803@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: akpm@digeo.com
cc: linux-kernel@vger.kernel.org
Subject: 2.5.62-mm1 + qlogic + highmem DBT3 results
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Feb 2003 10:39:15 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One more test of 2.5.62-mm1 on a big memory system w/qlogic FC
controller. 

JennyZ has run OSDL's dbt3 workload on an 8-CPU system CONFIG_HIGHMEM4G=y
(she's out today, so i'm Mr.Hands) 

Dbt3 is a decision support workload.

"DBT3 power
load has some disk write and the beginning and end of
the run, most disk activity is read. I did not see any
problem during the run.

The file calc_power.out records the mesurement.  The
higher the power, the better the performance. "

Results for 2.5.62-mm1 at  (vmstat data in file vmstat.out) 

http://www.osdl.org/archive/jenny/2.5.62-mm1

Run of same test on 2.4.18-rh kernel
http://www.osdl.org/archive/jenny/2.4.18-redhat

cliffw



