Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUCKNmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUCKNmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:42:40 -0500
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:128 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261322AbUCKNmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:42:04 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.4-ck1
Date: Fri, 12 Mar 2004 00:41:26 +1100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403120041.50554.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patchset
http://kernel.kolivas.org


includes:
am
Autoregulates the virtual memory swappiness.

domains
sched_domains

smtnice
Make "nice" hyperthread smart

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

bs313
Bootsplash v3.1.3

reiser4
Reiser4 filesystem 


Changes:
Added:
Sched_domains for improved SMT (Hyperthreading), SMP and Numa support.
Reiser4 snapshot (see www.namesys.com for support tools)

Modified:
Swappiness autoregulation now has the option of changing from autoregulated 
swappiness to static swappiness on the fly:
echo 0 > /proc/sys/vm/autoswappiness
and then you can set the swappiness via the usual method
echo 60 > /proc/sys/vm/swappiness
Lots of resyncs with sched_domains mean some patches rolled up and 
incrementals may be more dependent on other patches now.

Con Kolivas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUGyGZUg7+tp6mRURAle5AKCHpSBR6W5NDhsPtQDAkKhazPkDTQCfXUiA
2sSWdbQTaFTRlzidMu7lfMY=
=y2Bq
-----END PGP SIGNATURE-----
