Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTJSQoY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTJSQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:44:24 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:35546 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262030AbTJSQoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:44:14 -0400
Subject: Root panics on test 5-8
From: Chris Anderson <chris@simoniac.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066581997.407.5.camel@kuso>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 12:46:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently attempted to upgrade from test1 to test8 and came across the
following error when I boot:

VFS: cannot open root device "2102" or unknown-block(33,2)
Please append a correct "root=" boot option

I have the filesystem of my root built into the kernel (ext3) and also
have pci ide and my ide chipset driver built in. I had this same issue
with test 5-7 as well though, but test 1 (the last one I've really
tried) works fine. I also have a friend with different hardware but the
same circumstances who encounters the same problem. Any help would be
appreciated.

Following is anything that might help in finding the cause:
My .config: http://www.simoniac.com/~chris/config.txt

lspci output:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP]
00:0a.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti
200] (rev a3)

-Chris



