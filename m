Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUKJKz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUKJKz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 05:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUKJKz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 05:55:26 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:28592 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261682AbUKJKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 05:55:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc1-mm4: USB storage not working on AMD64
Date: Wed, 10 Nov 2004 11:54:05 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411101154.05304.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There seems to be a problem in 2.6.10-rc1-mm4 with either USB storage (eg a 
pendrive) or hotplug on AMD64 (NForce3 chipset, ohci-hcd, SuSE 9.1).  Namely, 
if a USB pendrive is inserted into a socket, the kernel does not even detect 
it.  Here's what appears in dmesg after it's inserted:

ohci_hcd 0000:00:02.0: wakeup

Other USB devices (eg a mouse) seem to work normally.

Of course such problems do not occur on 2.6.10-rc1.  On 2.6.10-rc1-mm3 I've 
had this problem only on a dual-Opteron box, but on 2.6.10-rc1-mm4 I see it 
on a one-processor box either.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
