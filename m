Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275013AbTHLETF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 00:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275020AbTHLETF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 00:19:05 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:17663 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S275013AbTHLETB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 00:19:01 -0400
Date: Tue, 12 Aug 2003 00:18:57 -0400
From: A1tmblwd@netscape.net
To: linux-kernel@vger.kernel.org
Subject: BUG: linux-2.6.0-test3/drivers/char/riscom8.h  & linux-2.6.0-test3/drivers/char/riscom8.c 
MIME-Version: 1.0
Message-ID: <4FE3EB1C.2C54200D.005FFA64@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 12.235.79.240
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following errors were generated using gcc-3.3-14:


In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:84: error: field `tqueue' has incomplete type
drivers/char/riscom8.h:85: error: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in declaration of `DECLARE_TASK_Q UEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in function declaration
drivers/char/riscom8.c: In function `rc_mark_event':
drivers/char/riscom8.c:344: warning: implicit declaration of function `queue_task'
drivers/char/riscom8.c:344: error: `tq_riscom' undeclared (first use in this function)
drivers/char/riscom8.c:344: error: (Each undeclared identifier is reported only once
drivers/char/riscom8.c:344: error: for each function it appears in.)
drivers/char/riscom8.c:345: warning: implicit declaration of function `mark_bh'
drivers/char/riscom8.c:345: error: `RISCOM8_BH' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_receive_exc':
drivers/char/riscom8.c:428: error: structure has no member named `tqueue'
drivers/char/riscom8.c:428: error: `tq_timer' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_receive':
drivers/char/riscom8.c:459: error: structure has no member named `tqueue'
drivers/char/riscom8.c:459: error: `tq_timer' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_check_modem':
drivers/char/riscom8.c:547: warning: implicit declaration of function `schedule_task'
drivers/char/riscom8.c: In function `rc_open':
drivers/char/riscom8.c:1050: warning: unused variable `flags'
drivers/char/riscom8.c: In function `do_riscom_bh':
drivers/char/riscom8.c:1662: warning: implicit declaration of function `run_task_queue'
drivers/char/riscom8.c:1662: error: `tq_riscom' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_init_drivers':
drivers/char/riscom8.c:1713: warning: implicit declaration of function `init_bh'
drivers/char/riscom8.c:1713: error: `RISCOM8_BH' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_release_drivers':
drivers/char/riscom8.c:1756: warning: implicit declaration of function `remove_bh'
drivers/char/riscom8.c:1756: error: `RISCOM8_BH' undeclared (first use in this function)
drivers/char/riscom8.c: At top level:
drivers/char/riscom8.c:84: warning: `DECLARE_TASK_QUEUE' declared `static' but never defined


Regards,

Kam Leo


__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455
