Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUGMKkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUGMKkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGMKkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:40:23 -0400
Received: from web52510.mail.yahoo.com ([206.190.39.135]:36512 "HELO
	web52510.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264826AbUGMKkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:40:06 -0400
Message-ID: <20040713104002.10597.qmail@web52510.mail.yahoo.com>
Date: Tue, 13 Jul 2004 03:40:02 -0700 (PDT)
From: Shobhit Mathur <shobhitmmathur@yahoo.com>
Subject: SCSI Query - cmd_per_lun & can_queue ...
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a basic query related to the Scsi_Host_Template
fields namely : cmd_per_lun and can_queue. I would
like
to know what is the relation between the per-lun queue
and the per-HBA queue ?

To elaborate my query, I would like to know how are
the
I/Os from the upper-layers managed between per-lun and
the host-queue depth. In most cases the host-queue
depth
is very large [128 or more], while the per-lun queue
is
a fraction [5 or 2]. I would like to know how is the
relation between the two queues and how does this
impact
io-rate ?

- Kindly let me know as I have a blurred picture of
the
role of the 2 queues.

- Thank you very much

- Shobhit Mathur


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
