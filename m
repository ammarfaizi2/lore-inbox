Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTJ3Vdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTJ3Vdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:33:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43762 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262888AbTJ3Vde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:33:34 -0500
Subject: [ANNOUNCE] JFS 1.1.4
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1067549605.29596.50.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 30 Oct 2003 15:33:25 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.1.4 of JFS was made available today.

Drop 67 on October 30, 2003 includes fixes to the file system and
utilities.

Utilities changes

- Work around gcc 2.95 bug
- Handle log full without crashing
- Message format fix

File System changes

- Make sure journal buffer gets flushed to disk
- Improved error handling
- Remove racy, redundant call to block_flushpage
- Fix race between link() and unlink()

Note: The 2.4.23 and 2.6 kernel.org development kernels are kept up to 
date with the latest JFS code.  The file system updates available on 
the web site are only needed for maintaining earlier 2.4 kernels.

For more details about JFS, please see our website:
http://oss.software.ibm.com/jfs
-- 
David Kleikamp
IBM Linux Technology Center

