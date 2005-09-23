Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVIWAWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVIWAWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVIWAWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:22:31 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:21165 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1751225AbVIWAWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:22:30 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200509230022.j8N0MPG4013164@clem.clem-digital.net>
Subject: 2.6.14-rc2-git2 fails compile -- fs/proc/base.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Thu, 22 Sep 2005 20:22:25 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fyi:

  CC      fs/proc/base.o
fs/proc/base.c: In function `proc_task_root_link':
fs/proc/base.c:360: parse error before `struct'
fs/proc/base.c:362: `task' undeclared (first use in this function)
fs/proc/base.c:362: (Each undeclared identifier is reported only once
fs/proc/base.c:362: for each function it appears in.)
make[2]: *** [fs/proc/base.o] Error 1
make[1]: *** [fs/proc] Error 2

-- 
Pete Clements 
