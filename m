Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVACTSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVACTSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVACTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:17:32 -0500
Received: from iris.icglink.com ([216.183.105.244]:30404 "EHLO
	iris.icglink.com") by vger.kernel.org with ESMTP id S261779AbVACTOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:14:08 -0500
Date: Mon, 3 Jan 2005 13:11:27 -0600
From: Phil Dier <phil@icglink.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: oops with software raid, lvm, xfs, nfs and smp
Message-Id: <20050103131127.777825d9.phil@icglink.com>
Organization: ICGLink
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted a while back about a storage array I'm setting up using
Software RAID, LVM, XFS, and NFS. Some problems have been fixed in the
2.6.10 release, however one problem remains and exhibits itself during
heavy I/O that appears to be related to XFS.

Due to its size, I've posted my debug info at this location (I've
included output from all of the above kernels):

<http://www.icglink.com/cluster-debug-2.html> (~80kb)

Please let me know if I've left anything out that would help in
locating the source of the problem. I'm very willing to try out any
patches/config changes.

please cc me on any replies, as I am not subscribed to the list...


--

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
