Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTIMMCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 08:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTIMMCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 08:02:55 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:44243
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262076AbTIMMCx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 08:02:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.22-ck2
Date: Sat, 13 Sep 2003 22:10:35 +1000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309132210.46837.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is an update to my patchset:

http://kernel.kolivas.org

Includes:

O(1) Scheduler
Batch scheduling
Preemptible
Low Latency
O1int interactivity
AA VM addons
Read Latency2
Variable HZ
Supermount-NG
Bootsplash
XFS
GRSec
Desktop tuning

Split out patches available on the website; incrementals available on request 
(my bandwidth / storage is limited sorry).

Changes:
The O1int interactivity backport is more substantial now bringing it in line 
with O20.1int with only the nanosecond resolution missing from the 2.6 work.
CK vm hacks and swap prefetch were dropped and AA Vm addons were merged as 
part of the default - lack of time prevented me maintaining ck vm properly.
XFS Merged - thanks Rik
GRSec Merged - thanks Rik

The slow termination of applications is fixed by the completion of the 
interactivity backport to this version.

Feel free to send me comments, queries, suggestions, patches and bug reports.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Ywk9ZUg7+tp6mRURAioHAJ46qHL8zO8Vg/lmXTlk99+WCGD1YwCfU/Gg
SurHyuGKhGhgF2R5t7sWPtI=
=/p/1
-----END PGP SIGNATURE-----

