Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVFUWfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVFUWfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVFUW2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:28:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:61841 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262547AbVFUVjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/11] ppc64: Introduce Cell/BPA platform, v3
Date: Tue, 21 Jun 2005 23:10:53 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506212310.54156.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support for a fifth platform type in the
ppc64 architecture tree. The Broadband Processor Architecture (BPA)
is what machines using the Cell processor should be following
and currently only prototype hardware exists for it.

Most of the functionality is the same as in the previous version.
The main updates are:

- Fixes for the comments I got
- Added more patches for moving rtas related stuff around from pSeries,
  so we can use it from BPA as well
- Smaller bug fixes
- Lots of changes on the SPU file system (see the patch comments)

One thing that has happened is that the Cell Processor Based Blade
has now been shown on E3 and the Power.org press summit and will 
also be on Linuxtag, so you can now see what kind of hardware this
runs on.

This series does not include the libspu files, as we are doing some changes
to the library right now. I'm also not including the driver for our network
driver yet. It's working well, but I'm waiting for a cleanup patch and
plan to submit it after Linuxtag.

Please forward these patches for inclusion in 2.6.13 if you are happy
with them. The spufs code is still not ready for inclusion, but it could
start a life in -mm to get a broader review at this point.

	Arnd <><

