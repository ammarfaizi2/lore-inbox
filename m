Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTGTKiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbTGTKiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:38:51 -0400
Received: from svr7.m-online.net ([62.245.150.229]:64455 "EHLO
	svr7.m-online.net") by vger.kernel.org with ESMTP id S265591AbTGTKiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:38:51 -0400
Date: Sun, 20 Jul 2003 12:55:47 +0200
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
Message-Id: <20030720125547.11466aa4.florian.huber@mnet-online.de>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ML,
I can't boot my 2.6.0-test1-mm2 kernel (+GCC 3.3). The kernel panics
at bootime:

VFS: Cannot open root device "hda3" or unknow-block(0,0)
Please append a correct "root=" boot option
Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)

I do have compiled support for the file system on my root partition
(xfs). The same configuration worked well with 2.6.0-test1-mm1.

Perhaps somebody knows how to solve this.

TIA
	Florian Huber
