Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSLOPQv>; Sun, 15 Dec 2002 10:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSLOPQv>; Sun, 15 Dec 2002 10:16:51 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:34385 "EHLO
	ubik.localnet") by vger.kernel.org with ESMTP id <S261686AbSLOPQu>;
	Sun, 15 Dec 2002 10:16:50 -0500
Message-ID: <3DFC9E8E.8040702@murphy.dk>
Date: Sun, 15 Dec 2002 16:23:58 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King <rmk@arm.linux.org.uk>
Subject: serial_pci_tbl is incorrect for some Titan devices
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are still some Titan devices defined around line 990 in
8250_pci which use the old format for this structure. Is there
any chance that the patch I submitted a while ago to fix this
problem will be accepted?

The same problem exists in the 2.4 serial driver.

/Brian

