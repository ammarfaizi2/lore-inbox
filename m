Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270023AbUJHRgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270023AbUJHRgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270045AbUJHRgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:36:39 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:47870 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S270023AbUJHRgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:36:36 -0400
Date: Fri, 8 Oct 2004 19:36:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for -bk.
Message-ID: <20041008173624.GA7356@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I have 12 patches for -bk. The first 7 are bug fixes and small improvements.
The remaining 5 pathces are new features. I'd suggest to push the bug fixes
to -bk right away (probably minus the zfcp one since it isn't really small
and we are quite late into 2.6.9 already) and keep the new features back
for early 2.6.10 and add them to -mm in the meantime.

Short overview:
1) s390 core changes
2) common i/o layer bug fixes
3) dasd driver bug fixes
4) monitor stream stack reduction
5) add module parameter for dcss block driver
6) qeth driver bug fix.
7) zfcp adapter bug fixes.

8) layer 2 support for osa-express cards (qeth driver)
9) z/VM watchdog timer support (new driver)
10) z/VM log reader support (new driver)
11) add support for zero-pad and crypto express II (crypto driver)
12) add support to read z/VM monitor records (new driver)

blue skies,
  Martin.

