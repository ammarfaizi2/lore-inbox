Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUIGLa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUIGLa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUIGLa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:30:26 -0400
Received: from unicorn.sch.bme.hu ([152.66.208.4]:27833 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S267851AbUIGLaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:30:25 -0400
Date: Tue, 7 Sep 2004 13:30:21 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sch_atm license
Message-ID: <20040907113021.GA4624@unicorn.sch.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently net/sched/sch_atm.c misses the license tag.
I am not 100% sure that it is licensed under the GPL, but I suppose so, 
and if it is, the following patch should be applied.


Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>

diff -Naurd a/net/sched/sch_atm.c b/net/sched/sch_atm.c
--- a/net/sched/sch_atm.c	2004-05-10 04:32:29.000000000 +0200
+++ b/net/sched/sch_atm.c	2004-05-30 16:29:37.277776273 +0200
@@ -713,3 +713,4 @@
 
 module_init(atm_init)
 module_exit(atm_exit)
+MODULE_LICENSE("GPL");



-- 
pozsy
