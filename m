Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbTIQVN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbTIQVN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:13:57 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:55230 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262651AbTIQVMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:12:36 -0400
Date: Wed, 17 Sep 2003 17:12:34 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: wait_on_irq, CPU 1:
In-Reply-To: <20030917210545.GS1758@ovh.net>
Message-ID: <Pine.LNX.4.58.0309171709580.12413@filesrv1.baby-dragons.com>
References: <20030917210545.GS1758@ovh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All ,  Any more info I can pass along ?  This got dumped
	into my /var/log/syslog .  Please advise .  Tia ,  JimL

Sep 17 15:00:59 filesrv1 kernel:
Sep 17 15:00:59 filesrv1 kernel: wait_on_irq, CPU 1:
Sep 17 15:00:59 filesrv1 kernel: irq:  0 [ 0 0 ]
Sep 17 15:00:59 filesrv1 kernel: bh:   1 [ 2 0 ]
Sep 17 15:00:59 filesrv1 kernel: Stack dumps:
Sep 17 15:00:59 filesrv1 kernel: CPU 0: <unknown>
Sep 17 15:00:59 filesrv1 kernel: CPU 1:c2b29f34 c03f8fdd 00000001 00000020 00000000 c2b29f60 c010a79d c03f8ff2
Sep 17 15:00:59 filesrv1 kernel:        c04bc104 f70a8000 00000001 c2b29f7c c01f8006 c04bc104 c2b29f94 00000282
Sep 17 15:00:59 filesrv1 kernel:        f70a876c f70a836c c2b29f9c c01224dc f70a8000 c2b28000 c2b2865c ffffffff
Sep 17 15:00:59 filesrv1 kernel: Call Trace:    [<c010a79d>] [<c01f8006>] [<c01224dc>] [<c012bc0b>] [<c0107448>]
Sep 17 15:00:59 filesrv1 kernel:
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
