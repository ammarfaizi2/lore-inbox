Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVCXP7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVCXP7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVCXP7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:59:49 -0500
Received: from smartmx-05.inode.at ([213.229.60.37]:40356 "EHLO
	smartmx-05.inode.at") by vger.kernel.org with ESMTP id S263099AbVCXP7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:59:15 -0500
Subject: INITRAMFS: junk in compressed archive
From: Bernhard Schauer <linux-kernel-list@acousta.at>
Reply-To: schauer@acousta.at
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 16:59:32 +0100
Message-Id: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Kernel 2.6.11.5 issue:

Passing .cpio.gz image with loadlin and initrd= kernel parameter. While
booting, the "checking if image is initramfs... it isn't (junk in
compressed archive)" message is shown.

To create the cpio.gz file I issued 

"find . | cpio -o -H newc | gzip -9 >../initram.gz".

What is going wrong while that procedure? I tried to find out what
exactly happens, found the method where it happens,... but can't track
it down to why it happens.

Is anyone out there knowing what that means? (I googled about that
issue, but can't find a solution also looked at Documentation/early-
userspace) Can someone please point me into the right direction?

best regards,

Bernhard Schauer
ACOUSTA

