Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUHIMSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUHIMSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUHIMQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:16:45 -0400
Received: from CPE-65-30-20-102.kc.rr.com ([65.30.20.102]:15237 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S266532AbUHIMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:15:45 -0400
Message-ID: <37954.192.168.1.12.1092053741.squirrel@192.168.1.12>
Date: Mon, 9 Aug 2004 07:15:41 -0500 (CDT)
Subject: uhci-hcd oops with 2.4.27/ intel D845GLVA
From: "Nick Bartos" <spam99@2thebatcave.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I unable to boot due to a kernel oops on my D845GLVA.  This worked fine in
2.4.26, but with the same (well, except for the new features) config
2.4.27 does not.

If I disable usb 2.0 support in the kernel or disable the usb 2.0
controller, then the system will boot fine.  However I would like to be
able to use the 2.0 controller.

I upgraded the bios on the board to the latest, but no change.

I am not certain how everyone gets all that info captured when the kernel
crashed, but here is what I wrote down:

ehci_hcd 00:1d.7:  Bios handoff failed (104, 1010001)
unable to handle kernel NULL pointer dereference at virtual address 00000048

...

kernel panic:  attempted to kill init!


