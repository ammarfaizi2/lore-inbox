Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTF3O6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTF3O6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:58:23 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:44420 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264802AbTF3O6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:58:22 -0400
Message-Id: <5.1.0.14.2.20030630170916.00afd930@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 30 Jun 2003 17:13:05 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.73 compile warnings
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: bRrzu4ZSoej-O8kuXa12L11JzXKkhdmvsel7Zg15qlUqXNAj2PMAko@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.73 + latest cset
GCC 3.3

kernel/suspend.c:294:2: warning: #warning This might be broken. We need to 
somehow wait for data to reach the disk

drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to 
limited range of data type
drivers/char/vt_ioctl.c:85: warning: comparison is always false due to 
limited range of data type
drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
drivers/char/vt_ioctl.c:211: warning: comparison is always false due to 
limited range of data type

drivers/char/keyboard.c: In function `k_fn':
drivers/char/keyboard.c:665: warning: comparison is always true due to 
limited range of data type

drivers/pnp/isapnp/core.c: In function `isapnp_next_rdp':
drivers/pnp/isapnp/core.c:263: warning: `check_region' is deprecated 
(declared at include/linux/ioport.h:116)

