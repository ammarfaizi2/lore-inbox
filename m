Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTJBViJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbTJBViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:38:09 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:25472
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S263496AbTJBViH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:38:07 -0400
Message-Id: <200310022138.h92Lc67x005420@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 - Network doesn't come up.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Oct 2003 15:38:06 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Im trying to run 2.6.0-test6 on top of RH9.
I have progress in some areas but not others.

NETWORKING. is a nogo.

If I compile the driver 3c59x as a module, it gets loaded, but
with the driver in the kernel or as a module, I get the messages
in the messages file (during boot) or when I do a ./network start
from /etc/rc.d/init.d

---

[root@orion init.d]# ./network* restart
Shutting down interface eth0:                              [  OK  ]
Shutting down loopback interface:                          [  OK  ]
Setting network parameters:                                [  OK  ]
Bringing up loopback interface:  arping: socket: Address family not supported 
by protocol
Error, some other host already uses address 127.0.0.1.
                                                           [FAILED]
Bringing up interface eth0:  arping: socket: Address family not supported by 
protocol
Error, some other host already uses address 204.134.2.19.
                                                           [FAILED]

---

                                        Reg.Clemens
                                        reg@dwf.com


