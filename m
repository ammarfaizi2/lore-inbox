Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWAILau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWAILau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 06:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWAILau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 06:30:50 -0500
Received: from math.ut.ee ([193.40.36.2]:33778 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751122AbWAILau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 06:30:50 -0500
Date: Mon, 9 Jan 2006 13:30:35 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.15+git: undefined reference to `pm_power_off'
Message-ID: <Pine.SOC.4.61.0601091329540.14603@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todays git update does not link on sparc64:

   LD      .tmp_vmlinux1
kernel/built-in.o: In function `sys_reboot': undefined reference to `pm_power_off'
kernel/built-in.o: In function `sys_reboot': undefined reference to `pm_power_off'

-- 
Meelis Roos (mroos@linux.ee)
