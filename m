Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTDIOiT (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 10:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbTDIOiT (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 10:38:19 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:41375 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263475AbTDIOiS convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 10:38:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ck5
Date: Thu, 10 Apr 2003 00:50:40 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304100051.05470.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've posted an update to my patchset:

http://kernel.kolivas.org

O(1) scheduler
Interactivity backport
Preempt
Low Latency
AA VM
Read Latency2
Supermount
XFS 1.2
ACPI
CD/DVD Packet Writing
Variable HZ
Scheduler Tunables
Desktop Tuning
+/- Rmap15e

Significant updates:
The interactivity changes to the O(1) scheduler by Mingo have been 
incorporated.
Supermount has had a minor touch up to remove annoying warnings on shutdown.
XFS has been updated to the latest snapshot.
Hz may be set at config time again
Scheduler tunables has been backported from 2.5
Rmap has been updated to 15e

It became clear that even with the interactivity changes audio skipping could 
occur so I've added some more desktop tuning to this version far less drastic 
than the previous kernels. The desktop tuning patch just changes a few of the 
default settings and these are all able to be modified at config or after 
boot if so desired. The options chosen were:

Hz set to 500
Min timeslice set to 2ms
Max Timeslice set to 40ms

A FAQ on NOT renicing X with this kernel has been added to my homepage.

Please feel free to send me comments, queries, suggestions, bug reports, 
patches etc.

Enjoy!
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lDNAF6dfvkL3i1gRAqVSAJ4v6YMFE4OH0hN/EeOM5xssu7JrqwCglp3t
DXDZ8zNH90jxivl7I4nKee8=
=TZkg
-----END PGP SIGNATURE-----

