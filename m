Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVDEUep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVDEUep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVDEUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:33:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18097 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262000AbVDEUZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:25:03 -0400
Subject: JFS supports larger page size in linux-2.6.12-rc2-mm1
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 15:24:59 -0500
Message-Id: <1112732699.8677.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have finally added support for a page size greater than 4K for jfs and
the code is now in 2.6.12-rc2-mm1.  This will allow jfs to work on
architectures with larger page sizes: alpha, sparc, all configs of ia64,
etc.

I completely replaced the address-space operations for jfs's metadata,
and I expect to see some performance improvements on workloads that
stress metadata operations.

I welcome anybody interested to stress jfs on 2.6.12-rc2-mm1 and give me
any feedback, bug reports, flames, etc.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

