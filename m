Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSKNF4w>; Thu, 14 Nov 2002 00:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSKNF4w>; Thu, 14 Nov 2002 00:56:52 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:57535 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S264766AbSKNF4v>;
	Thu, 14 Nov 2002 00:56:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ck performance patchset updated to 2.4.19-ck14
Date: Thu, 14 Nov 2002 17:03:09 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211141703.39883.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've updated my patchset for the stable kernel.

It includes 
O(1) Batch scheduler
Preemptible
Low Latency
AA VM addons
Compressed caching VM
Optional RMAP14c VM
ALSA
Supermount
XFS
ACPI

Changes to this release:

Andrea Arcangeli's fix for "processes stuck in D" has been put in. It was a 
serious recurring problem with my patchset. It seemed to be responsible for 
the pausing seen by a few. Compressed caching now works fine with the aa vm 
addons as well so they are merged. Minor changes to cc should make it safer 
for ext3 but I dont guarantee it so only try it on experimental boxes. XFS 
has been updated to the 1.2pre3 release. Rmap has been updated to 14c. A full 
split out patchset is also available. 

Check it out here:
http://kernel.kolivas.net

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE90zyhF6dfvkL3i1gRAmNdAKCsBpcF125i70dmuXTS0UFiMbLs0QCeO9Yx
xJ4Jo2Z3V8da6hqAooeJlHs=
=TzYJ
-----END PGP SIGNATURE-----
