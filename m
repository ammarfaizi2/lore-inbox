Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbTJTX6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJTX6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:58:24 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:34564 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S263108AbTJTX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:58:22 -0400
Subject: [BUG] linux-2.6.0-test8 : sleep in invalid context #1
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1066694576.3916.1.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 17:02:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011da5f>] __might_sleep+0xa0/0xc1
 [<c0120722>] acquire_console_sem+0x3a/0x59
 [<c0120957>] register_console+0x9f/0x1ca
 [<c0105000>] _stext+0x0/0x61
 [<c0746a17>] serial8250_console_init+0x17/0x1d
 [<c0745188>] console_init+0x33/0x40
 [<c073262a>] start_kernel+0xbd/0x1af
 [<c073243f>] unknown_bootoption+0x0/0xfa

-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


