Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270819AbTHKAmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTHKAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 20:42:06 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36830 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270819AbTHKAmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 20:42:05 -0400
From: Geoff Rivell <grivell@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] USB Mass-Storage hdparm -t
Date: Sun, 10 Aug 2003 20:44:16 -0400
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308102044.16226.grivell@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a USB2 hard drive and it crashes on hdparm -t /dev/sda.

The Gentoo 2.4 kernel worked perfectly with it (although it only was 8mb/sec).

Is this a known problem?  It also crashes on a 'du' to the root dir.  
Basically anything that pushes the disk.

This is on Kernel 2.6.0-test2 and test3.

I have not tested on previous kernels.

After the crash, I can't access /dev/sda at all.

