Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTDPXez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDPXez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:34:55 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:36042 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261910AbTDPXey convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:34:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ck6
Date: Thu, 17 Apr 2003 09:48:35 +1000
User-Agent: KMail/1.5.1
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304170948.40979.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Full update to my patchset

Includes:
O(1)
Preempt
Low Latency
AA VM addons
Read Latency2
Supermount
XFS
ACPI
DVD/CDRW Packet writing
Variable Hz
Scheduler Tunables
Desktop Tuning

optional:

Interactivity updates from 2.5
Rmap15f
Compressed Caching

Changes from ck5:
The buggy interactivity patch was backed out and a fresh one from Eric Wong 
wad made as an optional addon.
Small O(1) changes from 2.5 are now integral
Desktop tuning now sets Hz to 200, min timeslice to the minimum possible for 
your Hz setting and max timeslice to 40ms.  It also includes small tweaks to 
the AA VM and RL2 for best desktop responsiveness.
500Hz was still too much for many machines at high load.
Compressed Caching available again by request

Impressions with the new interactivity patch:
Certainly some things seem a lot smoother, and xmms wont skip a beat until I 
do a make -j64 on my kernel compile. However it skips reproducibly while 
scrolling a bar in quanta+ with nothing else running. 

I'm keen to get lots more feedback on the interactivity patch from people 
interested in it, and those who had mem leaks.

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nevTF6dfvkL3i1gRAr24AJ90LQc0cum+YSdNUtpcXMb1od4nMACffrJl
c4VCKkDoFWX34Iw8P2859n4=
=yKP1
-----END PGP SIGNATURE-----

