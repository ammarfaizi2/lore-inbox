Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUFHOYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUFHOYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUFHOYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 10:24:12 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:11426 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265212AbUFHOYJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 10:24:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] staircase scheduler v6.4 for 2.6.7-rc3
Date: Wed, 9 Jun 2004 00:23:40 +1000
User-Agent: KMail/1.6.1
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406090023.54421.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is an updated full version of the staircase scheduler (not attached for 
brevity of email):

http://ck.kolivas.org/patches/2.6/2.6.7-rc3/patch-2.6.7-rc3-s6.4

25 files changed, 264 insertions(+), 545 deletions(-)

Changes:
Tiny bugfixes, cleanups.
Slight tweak to tasks waiting on I/O
Massive cleanups from wli - thanks!

Comments, testing welcome
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxcvsZUg7+tp6mRURAgZFAJ4/iTCfBF/AotI70tbjPgW3xPy2TACggYgS
38J+HdFXv0lThCUzx07kNhM=
=eO0E
-----END PGP SIGNATURE-----
