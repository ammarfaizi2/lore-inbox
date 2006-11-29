Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967481AbWK2RPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967481AbWK2RPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967486AbWK2RPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:15:41 -0500
Received: from mgw-ext13.nokia.com ([131.228.20.172]:6287 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP id S967481AbWK2RPk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:15:40 -0500
Subject: [PATCH] UBI
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
       haver@vnet.ibm.com, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
       arnez@vnet.ibm.com, linux-mtd@mgw-ext13.nokia.com,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Nov 2006 19:02:49 +0200
Message-Id: <1164819769.576.53.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 29 Nov 2006 17:02:49.0821 (UTC) FILETIME=[3351C8D0:01C713D8]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061129190257-0C1B0BB0-64155D47/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

we have announced UBI several months ago in the MTD mailing list. It was
successfully used in our setup and we've got positive feedback.

In short, it is kind of LVM layer but for flash (MTD) devices which
hides flash devices complexities like bad eraseblocks (on NANDs) and
wear. The documentation is available at the MTD web site:
http://www.linux-mtd.infradead.org/doc/ubi.html
http://www.linux-mtd.infradead.org/faq/ubi.html

The source code is available at the UBI GIT tree:
git://git.infradead.org/home/dedekind/ubi-2.6.git

The UBI GIT tree is based upon the mtd-2.6.git
(git://git.infradead.org/mtd-2.6.git)

Plain patches may be found at
http://linux-mtd.infradead.org/~dedekind/ubi/

Please, include the patches to your tree.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

