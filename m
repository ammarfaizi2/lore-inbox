Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUGVUZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUGVUZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUGVUZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:25:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43956 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267223AbUGVUZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:25:08 -0400
Subject: [ANNOUNCE] jfsutils 1.1.7
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1090524493.17486.73.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jul 2004 14:28:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.1.7 of jfsutils was made available today.

This release include the following changes to the utilities:

    - --replay_journal_only should not clear FM_DIRTY
    - Ensure changes to disk occur in the proper order
    - Message corrections
    - Directory Index Table corrections for big-endian systems.

The last of these is the most critical.  Anyone using version 1.1.6 on a
big-endian system (i.e. ppc64) should update to version 1.1.7.

For more details about JFS, please see our website:
http://oss.software.ibm.com/jfs
-- 
David Kleikamp
IBM Linux Technology Center

