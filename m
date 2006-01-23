Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWAWQO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWAWQO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAWQO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:14:26 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:39303 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932348AbWAWQMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:12:24 -0500
Date: Mon, 23 Jan 2006 13:41:40 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 00/00] pktgen: refinements and small fixes.
Message-Id: <20060123134140.b04ad994.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi!

 I have the following patches for pktgen:

 [PATCH 00/01] pktgen: Lindent run.
 [PATCH 00/02] pktgen: Ports thread list to Kernel list implementation.
 [PATCH 00/03] pktgen: Fix kernel_thread() fail leak.
 [PATCH 00/04] pktgen: Fix Initialization fail leak. 

 All the patches were tested with QEMU, emulating a machine with 4 CPUs
and 4 ethernet cards.

 There is more work I'd like to do for pktgen, it includes:

 1. pg_cleanup() should freed the memory of the tasks it just terminated
 (there's a leak there I think)
 2. Port the interface list to the kernel linked list implementation
 3. Review pktgen's debug printk()s

 But I'm sending these patches first, just to know if I'm doing something
wrong.

 Thank you

-- 
Luiz Fernando N. Capitulino
