Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUGRRGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUGRRGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 13:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGRRGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 13:06:11 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:17955 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264297AbUGRRGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 13:06:06 -0400
Message-ID: <d6fc441b04071810063fcf493b@mail.gmail.com>
Date: Sun, 18 Jul 2004 10:06:06 -0700
From: Brian Litzinger <snblitz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Filesystem corruption 1,800,000 inodes and counting
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to double post.  The machine that is down processes most of my
email.  However,
this account works.

A machine froze after 30 days uptime.  After reboot, it fell out of
fsck with an unrecoverable
error.

I ran fsck -C -y /dev/md1.  At 73% it starting reporting

Unattached inode 250143
Connect to /lost+found? yes

Inode 1815609 ref count is 2, should be 1. Fix? yes

It has gone from 250143 to 1815610  doing this over the last 36 hours.

And so far as I know will do on doing this forever?

Linux 2.4.25 untainted. ext2 filesystem (no journaling).

Any advice on how I should proceed?
