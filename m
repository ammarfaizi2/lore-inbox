Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUCZPwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbUCZPwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:52:54 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:55508 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264061AbUCZPwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:52:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.4-ck2
Date: Sat, 27 Mar 2004 02:49:36 +1100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403270252.46873.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated my patchset:
These are patches designed to improve system responsiveness and add features 
with specific emphasis on the desktop.

http://kernel.kolivas.org

Full feature list:
am
 Autoregulates the virtual memory swappiness.
domains
 Sched_domains support for better hyperthreading and SMP support including my
 smt nice changes
stair
 A complete scheduler policy rewrite for interactivity and responsiveness
batch
 Batch scheduling.
iso
 Isochronous scheduling.
cfqioprio
 Complete Fair Queueing disk scheduler and I/O priorities
schedioprio
 Set initial I/O priorities according to cpu scheduling policy and nice
sng204
 Supermount-NG v2.0.4
bs314
 Bootsplash v3.1.4
reiser4
 Reiser4 filesystem
cddma
 DMA for cd audio
grsec
 Greater security (not included in default patch). 


Changelog
Additions:
+ Staircase scheduler - my complete scheduler policy rewrite for interactivity 
built on top of the current O(1) scheduler
+ CD audio DMA
+ Grsec (optional only in experimental dir as it breaks compile if disabled)

Changes:
~New batch scheduling (idle scheduling) policy from scratch based on new 
scheduler is much simpler and less prone to system starvation issues
~New isochronous scheduling (low latency, non real time scheduling for 
non-privileged users)
~Updated sched_domains
~Updated bootsplash v3.1.4
~Updated reiser4 snapshot (2004.03.25)

Unchanged:
Autoregulated vm swappiness
Supermount-NG v 2.0.4
CFQ I/O scheduler with I/O priority support.


This is my parting gesture as I'll be on extended leave from 31st March till 
the end of May.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZFESZUg7+tp6mRURAqWoAJ93P2eVEzJIwc6zN7X2d49omEJDQgCfWaDA
V6CEcS0wiWmigxNP9OFdtR0=
=iGeC
-----END PGP SIGNATURE-----
