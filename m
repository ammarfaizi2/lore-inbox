Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUDLGjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 02:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUDLGjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 02:39:21 -0400
Received: from fireext.infoflex.se ([195.100.101.101]:40153 "EHLO
	fireext.infoflex.se") by vger.kernel.org with ESMTP id S262574AbUDLGjU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 02:39:20 -0400
Date: Mon, 12 Apr 2004 08:41:48 +0200
From: Daniel Brahneborg <daniel.brahneborg@infoflexconnect.se>
To: linux-kernel@vger.kernel.org
Subject: block -> name ?
Message-ID: <20040412084148.A11645@infoflexconnect.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently my computer running Linux kernel 2.4.25 started
halting all of a sudden, and running badblocks a couple
of times showed that it was caused by reading around block
20.200.000 on one of the SATA disks. I'll replace the
drive eventually, but is there a way of finding out what
file is currently residing in a specific block? I'd prefer
something a bit more efficient than doing a 'wc' on 300GB
of data (which also would miss all the directories).  To
make things more interesting, the disk is 1 of 4 in a RAID5
array, and is formatted with XFS.

Best regards,

/Daniel

