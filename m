Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFTLwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFTLwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFTLwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:52:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24996 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261210AbVFTLwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:52:47 -0400
Date: Mon, 20 Jun 2005 17:31:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com, ysaito@hpl.hp.com
Subject: Pending AIO work/patches
Message-ID: <20050620120154.GA4810@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since AIO development is gaining momentum once again, ocfs2 and
samba both appear to be using AIO, NFS needs async semaphores etc,
there appears to be an increase in interest in straightening out some
of the pending work in this area. So this seems like a good
time to re-post some of those patches for discussion and decision.

Just to help sync up, here is an initial list based on the pieces
that have been in progress with patches in existence (please feel free
to add/update ones I missed or reflected inaccurately here):

(1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
	Status: Updated to 2.6.12-rc6, needs review
(2) Buffered filesystem AIO read/write (me/Ben)
	Status: aio write: Updated to 2.6.12-rc6, needs review
	Status: aio read : Needs rework against readahead changes in mainline
(3) POSIX AIO support (Bull: Laurent/Sebastian or Oracle: Joel)
	Status: Needs review and discussion ?
(4) AIO for pipes (Chris Mason)
	Status: Needs update to latest kernels
(5) Asynchronous semaphore implementation (Ben/Trond?)
	Status: Posted - under development & discussion
(6) epoll - AIO integration (Zach Brown/Feng Zhou/wli)
	Status: Needs resurrection ?
(7) Vector AIO (aio readv/writev) (Yasushi Saito)
	Status: Needs resurrection ?

On my part, I'll start by re-posting (1) for discussion, and then
move to (2).

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

