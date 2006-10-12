Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWJLO1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWJLO1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWJLO1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:27:25 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:28118 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1422707AbWJLO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:27:24 -0400
Date: Thu, 12 Oct 2006 16:27:27 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: KDE confuses 2.6.19-rc1+ AKA "cdrom: This disc doesn't have any
 tracks I recognize!"
Message-ID: <20061012162727.207b730c@localhost>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a very strange problem.

With every post 2.6.18 kernel I've tried [2.6.19-rc1 -->
2.6.19-rc1-gc25d5180], the kernel is "confused" by KDE.

If I boot without starting KDE and put in a CD/DVD it works correctly.

If I start KDE and then put in a CD the kernel tells:
	cdrom: This disc doesn't have any tracks I recognize!

Manually mount still works but KDE shows it as a blank CD and I
cannot mount it through "media:/".


The kernel stays "confused" even if I close KDE...

I'm using KDE 3.5.4.

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
