Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264538AbTCYVNN>; Tue, 25 Mar 2003 16:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264542AbTCYVNN>; Tue, 25 Mar 2003 16:13:13 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:30253 "EHLO
	dyn94194207.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264538AbTCYVNM>; Tue, 25 Mar 2003 16:13:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] JFS 1.1.2
Date: Tue, 25 Mar 2003 15:24:21 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200303251524.21446.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.1.2 of JFS was made available today.

Drop 65 on March 25, 2003 includes fixes to the file system and 
utilities.

Utilities changes

- fix undefined reference to errno (G. D. Haraldsson)
- allow jfs_mkfs to run on regular file
- fix for-loop going past last element of vopen array
- sanity checking on variable this_ag
- s_label displayed incorrectly when 16 chars long

File System changes

- Clean up code flushing outstanding transactions to the journal
- Replace ugly debug macros with simpler ones
- Add get_index_page to eliminate unneeded I/O
- Fix hang while flushing outstanding transactions under heavy load
- Avoid deadlock under very heavy load
- Don't zero s_op during failed mount cleanup

Note: The 2.4.21 and 2.5 kernel.org development kernels are kept up to 
date with the latest JFS code.  The file system updates available on 
the web site are only needed for maintaining earlier 2.4 kernels.

For more details about JFS, please see our website:
http://oss.software.ibm.com/jfs

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

