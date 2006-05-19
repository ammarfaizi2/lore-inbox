Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWESSAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWESSAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWESSAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:20 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:53122 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932411AbWESSAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:20 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 0/6] Support scatter/gather I/O in NFS direct I/O path
Date: Fri, 19 May 2006 13:56:52 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for asynchronous scatter/gather I/O to the NFS
direct I/O engine.  They will apply cleanly to 2.6.17-rc4-mm1 with Badari's
API changes already applied.

Christoph, Badari, Trond, and Zach have already seen these at least once, but
they are in need of wider review and testing.  I'd welcome their inclusion in
an mm kernel.

-- 
corporate:   cel at netapp dot com
personal:    chucklever at bigfoot dot com
