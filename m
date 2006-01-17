Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWAQUQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWAQUQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWAQUQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:16:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12471 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964810AbWAQUQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:16:56 -0500
Date: Tue, 17 Jan 2006 21:16:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-xfs@oss.sgi.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: xfs depends on exportfs
Message-ID: <Pine.LNX.4.61.0601172112550.11929@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I could not find a clue on the first try on why xfs needs exportfs.
The Kconfig says "select EXPORTFS if CONFIG_NFSD!=n", but there are no 
occurrences of CONFIG_NFS* or CONFIG_EXP* in any of the files in fs/xfs/.
Did I miss something or this a superfluous line in Kconfig? Interestingly 
tho, `modinfo xfs.ko` returns "exportfs", so I suppose it's somewhere, well 
hidden. If so, where?


Regards,
Jan Engelhardt
-- 
