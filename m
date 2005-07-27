Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVG0UHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVG0UHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVG0UGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:06:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60346 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262485AbVG0UDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:03:51 -0400
Date: Wed, 27 Jul 2005 05:05:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.32-pre2
Message-ID: <20050727080512.GD7368@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes another -pre, after a long period.

A couple of USB corrections, a socket hashing bugfix and ipvs race
condition, avoidance of rare inode cache SMP race. 

And a zlib security update (erratic changelog for that one, my fault), 
whose CAN number is: CAN-2005-1849

Summary of changes from v2.4.32-pre1 to v2.4.32-pre2
============================================

Alan Stern:
  file_storage and UHCI bugfixes

David S. Miller:
  [NETLINK]: Fix two socket hashing bugs.

Jakub Bogusz:
  [SPARC64]: fix sys32_utimes(somefile, NULL)

Larry Woodman:
  workaround inode cache (prune_icache/__refile_inode) SMP races

Marcelo Tosatti:
  Change VERSION to 2.4.32-pre2
  Merge with rsync://rsync.kernel.org/.../davem/net-2.4.git
  Revert [NETLINK]: Fix two socket hashing bugs.

Neil Horman:
  [IPVS]: Close race conditions on ip_vs_conn_tab list modification

Pete Zaitcev:
  usb: printer double up()

Tim Yamin:
  Merge with rsync://rsync.kernel.org/.../davem/sparc-2.4.git/
  The gzip description is as good as the ChangeLog says it is -: "Set n to

