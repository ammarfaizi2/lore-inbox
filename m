Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTFUKE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 06:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTFUKE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 06:04:58 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:34702 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265113AbTFUKE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 06:04:57 -0400
Date: Sat, 21 Jun 2003 06:19:00 -0400
To: linux-kernel@vger.kernel.org
Subject: [ANN,OT] libivykis event handling library 0.4 is available
Message-ID: <20030621101900.GB923@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://sourceforge.net/project/showfiles.php?group_id=74441

Version 0.4 of the libivykis event handling library is available.

libivykis is a thin wrapper over various OS'es implementation of
I/O readiness notification facilities (such as poll(2), kqueue(2))
and is mainly intended for writing portable high-performance network
servers.

The main change in this release is the addition of infrastructure for
proper support for level-triggered poll methods, and implementations
for /dev/poll (Solaris), poll(2), select(2), kqueue(2) in level-triggered
mode, and sys_epoll in level-triggered mode.  libivykis now supports
both edge-triggered and level-triggered poll methods.

The list of supported poll methods is now:
- /dev/epoll (linux)
- /dev/poll (Solaris)
- kqueue (*BSD)
- kqueue level-triggered (*BSD)
- poll(2)
- realtime signals (linux)
- select(2)
- sys_epoll (linux)
- sys_epoll level-triggered (linux)


