Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270925AbTG0SSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTG0SSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 14:18:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61827 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270925AbTG0SSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 14:18:24 -0400
Date: Sun, 27 Jul 2003 19:33:37 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2: Fatal exception in interrupt
Message-ID: <20030727183337.GA671@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test1 (i686)
X-Uptime: 19:31:29 up 4 min,  1 user,  load average: 0.27, 0.29, 0.13
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dual athlon, (Tyan S2460 board with on board 768 and offboard
Promise).

Fatal exception in interrupt - I've got the last page of trace which
reads:

cdrom_decode_status
cdrom_read_intr
mempool_free
mempool_free
mempool_free
default_wake_function
__wake_up_common
cdrom_end_request
ide_intr
cdrom_read_intr
handle_IRQ_event
do_IRQ
default_idle
common_interrupt
default_idle
default_idle
cpu_idle
rest_idle
start_kernel
unknown_bootoption


Hmm - time to get serial console to log this stuff me thinks.

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
