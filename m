Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVCGRb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVCGRb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCGRb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:31:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28907 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261160AbVCGRbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:31:24 -0500
Subject: Re: [CHECKER] Do ext2, jfs and reiserfs respect mount -o
	sync/dirsync option?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiser@namesys.com,
       mc@cs.Stanford.EDU
In-Reply-To: <Pine.LNX.4.61.0503040831470.7350@yvahk01.tjqt.qr>
References: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
	 <Pine.LNX.4.61.0503040831470.7350@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110216555.28860.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Mar 2005 17:29:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IDE layer default is still unfortunately broken and leaves write
caching enabled. Turn it off with hdparm.

