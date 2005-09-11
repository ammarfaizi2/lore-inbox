Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVIKPBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVIKPBG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 11:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVIKPBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 11:01:06 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:16592 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964786AbVIKPBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 11:01:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck3
Date: Mon, 12 Sep 2005 01:01:00 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509120101.00649.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are patches designed to improve system responsiveness and interactivity. 
It is configurable to any workload but the default ck* patch is aimed at the 
desktop and ck*-server is available with more emphasis on serverspace.


Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck3/patch-2.6.13-ck3.bz2

or server version (still no new version this release):
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-server.bz2


web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
 +vm-sp2_sp5.patch
Updated the swap prefetch code to make it even gentler at deciding when to 
start prefetching.

 +patch-2.6.13.1.bz2
Latest stable version


Full patchlist:

sched-run_normal_with_rt_on_sibling.diff
2.6.13_to_staircase12.diff
schedrange.diff
schedbatch2.9.diff
sched-iso3.1.patch
smp-nice-support7.diff
1g_lowmem1_i386.diff
defaultcfq.diff
isobatch_ionice2.diff
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan.diff
vm-swap_prefetch-2.patch
sched-staircase12_tweak.patch
vm-sp2_sp5.patch
patch-2.6.13.1.bz2
2613ck3-version.diff


Cheers,
Con
