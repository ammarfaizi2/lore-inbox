Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVBUKfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVBUKfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVBUKfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:35:44 -0500
Received: from math.ut.ee ([193.40.36.2]:11774 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261941AbVBUKfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:35:39 -0500
Date: Mon, 21 Feb 2005 12:35:25 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: IDE warnings on sparc64
Message-ID: <Pine.SOC.4.61.0502211234440.9367@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays 2.6 BK snapshot on a sparc64:

   CC      drivers/ide/ide-iops.o
drivers/ide/ide-iops.c: In function `ide_insw':
drivers/ide/ide-iops.c:49: warning: passing arg 1 of `insw' makes pointer from integer without a cast
drivers/ide/ide-iops.c: In function `ide_insl':
drivers/ide/ide-iops.c:59: warning: passing arg 1 of `insl' makes pointer from integer without a cast
drivers/ide/ide-iops.c: In function `ide_outsw':
drivers/ide/ide-iops.c:79: warning: passing arg 1 of `outsw' makes pointer frominteger without a cast
drivers/ide/ide-iops.c: In function `ide_outsl':
drivers/ide/ide-iops.c:89: warning: passing arg 1 of `outsl' makes pointer frominteger without a cast


-- 
Meelis Roos (mroos@linux.ee)
