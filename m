Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUL1AST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUL1AST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUL1AST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 19:18:19 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34187 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262007AbUL1ASP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 19:18:15 -0500
Date: Tue, 28 Dec 2004 01:16:46 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: Luca Bortot <l.bortot@inet.it>, netdev@oss.sgi.com
Subject: [RFT] r8169 changes in 2.6.x
Message-ID: <20041228001646.GA29512@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The r8169 changes which Jeff kindly hosted in -netdev are now in
2.6.10-bk1.

This release should definitely improve the buzzword compliance of
the r8169 driver as it now features tx/rx ip chechsumming, tso,
vlan, netconsole and a more complete ethtool support.

Though available in -mm, large frames support is not included in
2.6.10-bk so far. It is available on top of 2.6.10-bk1 via:
- http://www.fr.zoreil.com/~romieu/misc/20041228-2.6.10-bk1-r8169.c-test.patch
  (single patch)
or:
- http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-bk1/r8169/patches/
  (a serie of smaller patches for review)
Large frames roughly means 7200 bytes frames at most.

Test results for regressions/improvements/stability will be welcome.


A backport is available for 2.4.x (x >= 28) at:
- http://www.fr.zoreil.com/~romieu/misc/20041209-2.4.28-r8169.c-test.patch
or:
- http://www.fr.zoreil.com/linux/kernel/2.4.x/2.4.28/r8169/patches

Thank you for your attention.

--
Ueimor
