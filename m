Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTLCP33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264967AbTLCP2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:28:53 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:45956
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264932AbTLCP2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:28:48 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.23-ck1
Date: Thu, 4 Dec 2003 02:28:44 +1100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312040228.44980.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated my patchset.

http://kernel.kolivas.org

Includes:
O(1) scheduler with batch scheduling, interactivity
Preemptible kernel
Low Latency
Read Latency2
Variable Hz
64bit jiffies
Supermount-NG v1.2.10
Bootsplash v3.0.7
XFS file system v1.3.1

Added:
64 bit jiffies - too many people were complaining of their uptime resetting 
after 49.7 days at 1000Hz (a good sign I guess) so I've added this patch from 
Robert Love
ACL and DMAPI for XFS

Updated:
Low latency points that were missing from reiserfs
Supermount-NG to latest version
Bootsplash to latest version
XFS to latest stable version.
Variable Hz is set to 1000 by default for all settings.

Removed:
AA VM hacks; they are now in vanilla kernel
GRSecurity: this will have to be a separate patch

Pending (maybe):
GRsec update
rmap option


Notes.
XFS is compile tested only. Test carefully before using in production 
environment.

I am no longer taking requests for more patches in this patchset, but I will 
accept sent patches/fixes. This release is mainly a resync and I don't have 
time for kernel development any more.

Con

