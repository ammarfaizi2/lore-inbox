Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbTFSKQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbTFSKQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 06:16:55 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:25032 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S265757AbTFSKQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 06:16:54 -0400
Date: Thu, 19 Jun 2003 13:30:52 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
To: linux-kernel@vger.kernel.org
Subject: SATA bus freeze with 2.4.21, sii3112A and Intel mb 7505vb, with
 max_kb_per_request 15
Message-ID: <Pine.LNX.4.53.0306191311520.27803@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Motherboard is:
http://www.intel.com/design/servers/SE7505VB2/index.htm?iid=ipp_srvr+mthrbds_se7505VB2_srvr&

Controller is sii3112a

I activated the trick with max_kb_per_request
Kernel 2.4.21 doesn't enable UDMA on the channels.
If I enable DMA (hdparm) the computer ALMOST freeze.
I can switch the consoles but with a 5 sec delay.
But, seems that the bus freeze. No activity even after 2 minutes.
I had to reboot.

Any ideas?
Thanks!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
