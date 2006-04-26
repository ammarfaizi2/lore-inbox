Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWDZTQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWDZTQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWDZTQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:16:15 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:62157 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S964841AbWDZTQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:16:14 -0400
Mime-Version: 1.0
Message-Id: <a0623092dc075772b201c@[129.98.90.227]>
Date: Wed, 26 Apr 2006 15:16:33 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: drbd-0.7.18 doesn't compile under 2.617-rc2 because SLAB_NO_REAP
 is missing
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being forwarded here from the drbd mailing list in case SLAB_NO_REAP 
got removed from the kernel source inadvertently....


>
>
>It was previously reported (twice) that drbd-0.7.17 didn't compile 
>under the initial releases of 2.6.17. Neither does 0.7.18.
>
>/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c: In 
>function `drbd_create_mempools':
>/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c:1547: 
>error: `SLAB_NO_REAP' undeclared (first use in this function)
>/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c:1547: 
>error: (Each undeclared identifier is reported only once
>/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.c:1547: 
>error: for each function it appears in.)
>make[3]: *** 
>[/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd/drbd_main.o] 
>Error 1
>make[2]: *** 
>[_module_/var/tmp/portage/drbd-0.7.18/work/drbd-0.7.18/drbd] Error 2
>--
>

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
