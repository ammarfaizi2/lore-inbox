Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTH3Nfv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbTH3Nfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:35:51 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:58044
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261512AbTH3Nft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:35:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.22-ck1
Date: Sat, 30 Aug 2003 23:43:02 +1000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308302343.04238.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patchset

http://kernel.kolivas.org

Includes:
O(1) scheduler
Batch scheduling
Preempt
Low latency
Interactivity updates
CK VM hacks
Swap prefetching
Read Latency2
Variable Hz
Supermount-NG 1.2.8
Bootsplash

Yet to be updated:
XFS
GRSEC
AAVM addons
RMAP

Dropped (either unstable, unecessary, too hard or too much of a moving 
target):
Scheduler tunables 
Packet Writing
Software Suspend 
ACPI
Nforce2
CPU Freq scaling

Changes:
Mainly a resync.
The conversion of nice 19+ priority tasks to batch scheduling was cleaned up.
A partial merge of the interactivity changes in 2.6-test* - O19int was done 
(no nanosecond resolution, no flagging of high credit tasks and 10ms 
timeslice granularity in this version).
All low latency points in swapfile.c were removed due to causing hanging in 
swapoff in combination with ckvm.
All non i386 arch changes were removed as they were getting increasingly 
broken and noone was reporting success with them (sorry).

Please feel free to send comments, suggestions, queries, bugreports, patches 
and requests.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/UKnmZUg7+tp6mRURApf+AJ9laZmu/AMFb6y37EUEOtHgNOFlQACcDv39
ldr5nLzeyTnI9lPitNnZ/JU=
=oyrC
-----END PGP SIGNATURE-----

