Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUGLPX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUGLPX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUGLPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:23:28 -0400
Received: from web52507.mail.yahoo.com ([206.190.39.132]:39844 "HELO
	web52507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266874AbUGLPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:23:11 -0400
Message-ID: <20040712152310.22995.qmail@web52507.mail.yahoo.com>
Date: Mon, 12 Jul 2004 08:23:10 -0700 (PDT)
From: Shobhit Mathur <shobhitmmathur@yahoo.com>
Subject: cmd_per_lun vs can_queue
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
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
