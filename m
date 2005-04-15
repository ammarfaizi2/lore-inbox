Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVDOITw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVDOITw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVDOITv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:19:51 -0400
Received: from smartmx-07.inode.at ([213.229.60.39]:16284 "EHLO
	smartmx-07.inode.at") by vger.kernel.org with ESMTP id S261769AbVDOITP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:19:15 -0400
Subject: Re: Booting from USB with initrd
From: Bernhard Schauer <linux-kernel-list@acousta.at>
To: gabriel <gabriel.j@telia.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <28347315.1113550056435.JavaMail.tomcat@pne-ps4-sn1>
References: <28347315.1113550056435.JavaMail.tomcat@pne-ps4-sn1>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 10:19:38 +0200
Message-Id: <1113553178.5347.8.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 09:27 +0200, gabriel wrote:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)

Hi Gabriel!

It looks like initrd.gz could not be mounted. The unknown-block(1,0)
is /dev/ram0 (and has normally initrd attached to it) as specified on
kernel command line.

Do you use an initrd or an initramfs? Is the kernel compiled with initrd
support? Is the ramdisk size big enough to hold your initrd?

regards


