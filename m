Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275257AbTHSAfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275262AbTHSAfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:35:14 -0400
Received: from acs-24-239-225-74.zoominternet.net ([24.239.225.74]:54524 "EHLO
	topaz") by vger.kernel.org with ESMTP id S275257AbTHSAfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:35:09 -0400
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: weird pcmcia problem
From: Narayan Desai <desai@mcs.anl.gov>
Date: Mon, 18 Aug 2003 19:34:59 -0500
Message-ID: <87u18efpsc.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.0-test3 (both with and without your recent yenta socket
patches) pcmcia cards present during boot don't show up until they are
removed and reinserted. Once reinserted, they work fine. This only
seems to occur if yenta_socket is build into the kernel; if support is
modular, cards appear to be recognized properly at boot time. I am
running on a thinkpad t21.  Let me know if I can help with this
problem in any way...  thanks
 -nld

messages from boot:
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 04b8, PCI irq11
Socket status: 30000010
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 04b8, PCI irq11
Socket status: 30000006

<later>

cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
