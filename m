Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967508AbWK2SSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967508AbWK2SSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967509AbWK2SSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:18:45 -0500
Received: from mgw-ext14.nokia.com ([131.228.20.173]:59792 "EHLO
	mgw-ext14.nokia.com") by vger.kernel.org with ESMTP id S967508AbWK2SSo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:18:44 -0500
Subject: [PATCH] UBI: take 2
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, haver@vnet.ibm.com,
       Josh Boyer <jwboyer@linux.vnet.ibm.com>, arnez@vnet.ibm.com,
       llinux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2006 20:17:26 +0200
Message-Id: <1164824246.576.65.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 29 Nov 2006 18:17:26.0260 (UTC) FILETIME=[9F7C2B40:01C713E2]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061129201817-6B02EBB0-03E2AB8B/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is take 2 of the previous mail with David's comments in mind.

Hello Andrew,

we have announced UBI several months ago in the MTD mailing list. It was
successfully used in our setup and we've got positive feedback.

In short, it is kind of LVM layer but for flash (MTD) devices which
hides flash devices complexities like bad eraseblocks (on NANDs) and
wear. The documentation is available at the MTD web site:
http://www.linux-mtd.infradead.org/doc/ubi.html
http://www.linux-mtd.infradead.org/faq/ubi.html

The source code is available at the UBI GIT tree:
git://git.infradead.org/ubi-2.6.git

The UBI GIT tree is based upon the mtd-2.6.git
(git://git.infradead.org/mtd-2.6.git)

There is also an 'mtd' branch available in the UBI GIT which contains
the current mtd-2.6.git. So that you can use git-diff mtd and have UBI
patches.

There is also web interface to the git trees available:
UBI: http://git.infradead.org/?p=ubi-2.6.git;a=summary
MTD: http://git.infradead.org/?p=mtd-2.6.git;a=summary

Plain patches may be found at
http://linux-mtd.infradead.org/~dedekind/ubi/

Please, include the patches to your tree.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

