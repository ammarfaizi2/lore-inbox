Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTFOUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTFOUM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 16:12:28 -0400
Received: from [66.155.158.133] ([66.155.158.133]:44672 "EHLO
	ns.waumbecmill.com") by vger.kernel.org with ESMTP id S262850AbTFOUM1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 16:12:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: linux-kernel@vger.kernel.org
Subject: How can you trace a reiserfs error to the device or filesystem?
Date: Sun, 15 Jun 2003 17:24:49 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306151724.49277.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get reiserfs errors like the ones below from my /var/log/syslog.  Is there a 
way to tell what device they are coming from?


csi kernel: is_tree_node: node level 35718 does not match expected one 1
csi kernel: vs-5150: search_by_key: invalid format found in block 9406, Fsck?
csi kernel: vs-13050: reiserfs_update_sd: i/o failure occurred trying to 
update [10145 51612 0x0 SD] stat datais_tree_node: node level 35718 does not 
match the expected one 1 

..
csi kernel: vs-5657:reiserfs_do_truncate: i/o failure occurred trying to 
truncate [10145 51612 0xffffffff DIRECT]


-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
