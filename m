Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUD1IBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUD1IBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUD1IBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:01:54 -0400
Received: from math.ut.ee ([193.40.5.125]:32940 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264660AbUD1IBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:01:53 -0400
Date: Wed, 28 Apr 2004 11:01:51 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: New warning from nfs code
Message-ID: <Pine.GSO.4.44.0404281058490.24906-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.6-rc3 on a sparc64:

  CC [M]  fs/nfs/direct.o
fs/nfs/direct.c: In function `nfs_direct_IO':
fs/nfs/direct.c:458: warning: int format, different type arg (arg 2)

ssize_t is long (64-bit) on sparc64 but int (32-bit) on i386 and so on.

-- 
Meelis Roos (mroos@linux.ee)

