Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291532AbSBXWJM>; Sun, 24 Feb 2002 17:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSBXWJD>; Sun, 24 Feb 2002 17:09:03 -0500
Received: from [216.174.202.133] ([216.174.202.133]:43013 "EHLO
	ark.dev.insynq.com") by vger.kernel.org with ESMTP
	id <S291533AbSBXWHv>; Sun, 24 Feb 2002 17:07:51 -0500
To: linux-kernel@vger.kernel.org, nkirsch@insynq.com
Subject: Problems with fsync
Message-Id: <E16f6lr-0004zR-00@ark.dev.insynq.com>
From: Nicholas Kirsch <nkirsch@insynq.com>
Date: Sun, 24 Feb 2002 14:05:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel geniuses:

I am using a Debian woody installation (3.0) with kernel 2.4.18-rc4 SMP. My root is mounted on an I2O device (Intel RAID SRCU-1). Whenever I run apt-get update, the process freezes and is completely unresponsive to any signal. When I do an strace, the fsync call is the last to appear, and it does not appear to successfully return. Is this an application, library or kernel issue? Once one application freezes, any other application that writes to the device (such as lilo) will freeze as well. Please help! Please CC any suggestions.

Thanks.

Nick <nkirsch@insynq.com>
