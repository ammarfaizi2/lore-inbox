Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTEABmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 21:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTEABmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 21:42:03 -0400
Received: from beauty.rexursive.com ([202.59.98.58]:9989 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S261362AbTEABmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 21:42:03 -0400
Message-ID: <1051754203.3eb07edb09c51@imp.rexursive.com>
Date: Thu,  1 May 2003 11:56:43 +1000
From: Bojan Smojver <bojan@rexursive.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried this on Red Hat 9 with 2.5.68 kernel (no modules), nfs-utils
version 1.0.1.

NFS3 server was running on the box and it was exporting a mounted /mnt/cdrom to
the world. On "umount /mnt/cdrom" it reported "device busy". On "eject
/mnt/cdrom" it locked the system hard.

One of the previous 2.5.x kernels that I've tried was .65 and that one would
lock up on NFS startup. So, things are better, but not yet completely good.

What kind of information would help debugging this?

-- 
Bojan
