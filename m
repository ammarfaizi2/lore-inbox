Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUBSNzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUBSNzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:55:31 -0500
Received: from web12603.mail.yahoo.com ([216.136.173.226]:31650 "HELO
	web12603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267258AbUBSNxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:53:14 -0500
Message-ID: <20040219135311.95851.qmail@web12603.mail.yahoo.com>
Date: Thu, 19 Feb 2004 05:53:11 -0800 (PST)
From: Joilnen Leite <pidhash@yahoo.com>
Subject: ide-scsi lock
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

excuse me friends shcedule_timeout(1) is not a problem
for spin_lock_irqsave ?



drivers/scsi/ide-scsi.c:897

spin_lock_irqsave(&ide_lock, flags);
while (HWGROUP(drive)->handler) {
       HWGROUP(drive)->handler = NULL;
       schedule_timeout(1);
}

pub 1024D/5139533E Joilnen Batista Leite 
F565 BD0B 1A39 390D 827E 03E5 0CD4 0F20 5139 533E


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
