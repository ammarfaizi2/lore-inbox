Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUBRMgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUBRMgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:36:46 -0500
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:15262 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266505AbUBRMgn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:36:43 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.3-ck1
Date: Wed, 18 Feb 2004 23:36:22 +1100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402182336.31420.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patchset

http://kernel.kolivas.org

Description:
am6
Autoregulates the virtual memory swappiness.

batch8
Batch scheduling.
+Updated batch logic to return cpu to non batch tasks asap
+Numa compile

iso2
Isochronous scheduling (non privileged low latency non-RT scheduling)
+Bypass file i/o and idle detection in interactivity estimation of SCHED_ISO 
tasks 

smtbase3
Base patch for hyperthread modifications
+Added SMT_SIBLING_IMPACT to reflect the percentage impact running a task on a 
sibling has. When a merge with sched_domains is done, this will be 
configurable for each architecture as this value will decrease as SMT designs 
improve.

smttweak2
Tiny performance enhancements for hyperthreading

smtnice4
Make "nice" hyperthread smart
+Minor bugfix
+Support for SMT_SIBLING_IMPACT to allow +niced tasks to run proportionately 
longer according to the value of SSI

smtbatch4
Make batch scheduling hyperthread smart

cfqioprio
Complete Fair Queueing disk scheduler and I/O priorities

schedioprio
Set initial I/O priorities according to cpu scheduling policy and nice

sng204
Supermount-NG v2.0.4


I've also synced the bootsplash patch with these but it doesn't complete 
booting on some machines so I've left this in the experimental dir for 2.6.3.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAM1xJZUg7+tp6mRURAgimAKCTUiHSaTa/8jP9yLOa5uSawWRhewCeNRdY
Jm8GjM7VeKq2bNRnRRk18T8=
=labP
-----END PGP SIGNATURE-----
