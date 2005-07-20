Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVGTOY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVGTOY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVGTOXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:23:10 -0400
Received: from athop1.ath.vt.edu ([128.173.120.79]:42368 "EHLO
	athop1.ath.vt.edu") by vger.kernel.org with ESMTP id S261240AbVGTOVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:21:43 -0400
Subject: Automating Kernel Builds
From: rbt <rbt@athop1.ath.vt.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Jul 2005 10:21:42 -0400
Message-Id: <1121869302.8610.10.camel@athop1.ath.vt.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a script that automatically builds kernels for testing. Would it
be possible to put the kernel version number (2.6.12.3) into the
'LATEST-IS-VERSION' file on http://www.kernel.org/pub/linux/kernel/v2.6/
or, is there some other file that traditionally has stored this info? I
searched the repository but could not find one.

As of now, my script goes to the site and parses the page searching for
a line that contains 'LATEST-IS' and then breaks that line apart and
attempts to extract the kernel version number from it. If
LATEST-IS-VERSION actually contained the version number (2.6.12.3)
instead of being a 0 byte file as it is now, then it my script could
simply read it and not have to do funky html parsing to get the latest
version number ;)

Thank you all.
