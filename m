Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265679AbUE1Bjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265679AbUE1Bjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 21:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbUE1Bjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 21:39:44 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:47245 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265679AbUE1Bjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 21:39:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] staircase scheduler 2.6.7-rc1
Date: Fri, 28 May 2004 11:39:36 +1000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405281139.37115.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a rewrite of the scheduler policy for 2.6, based on the current
O(1) scheduler.

http://ck.kolivas.org/patches/2.6/2.6.7-rc1/experimental/patch-2.6.7-rc1-s5.5

Here is a link to the original announcement email:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108017437616604&w=2

This release is mainly a bugfix and resync with 2.6.7-rc1. Some issues have 
been addressed with the bugfixes, and the overall design has not changed 
dramatically.

The previous version was run on a machine with 50 days of moderate use uptime 
suggesting reasonably good stability. I have yet to find any serious bugs 
with this release.

Please feel free to test and report back. Note I am quite aware there are 
still quirks, but for normal daily use it works very well at the moment. 
Depending on the level of interest I will decide how much to develop it.

Con Kolivas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtphYZUg7+tp6mRURApmIAJ9c+B670mjcO6Bhs11qBirAKM/WpwCeJW4n
vsMtWrUSLyySozOaWcmh0fU=
=ZGH8
-----END PGP SIGNATURE-----
