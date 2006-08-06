Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWHFKIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWHFKIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 06:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWHFKIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 06:08:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932379AbWHFKIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 06:08:15 -0400
Date: Sun, 6 Aug 2006 03:08:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc3-mm2
Message-Id: <20060806030809.2cfb0b1e.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

- 2.6.18-rc3-mm1 gets mysterious udev timeouts during boot and crashes in
  NFS.  This kernel reverts the patches which were causing that.



Changes since 2.6.18-rc3-mm1:


+revert-x86_64-mm-i386-remove-lock-section.patch

 Revert patch which caues udev timeouts.

-knfsd-make-rpc-threads-pools-numa-aware-fix.patch

 Folded into knfsd-make-rpc-threads-pools-numa-aware.patch

+revert-knfsd-make-rpc-threads-pools-numa-aware.patch

 Revert patch which causes nfs crashes.



All 1136 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/patch-list


