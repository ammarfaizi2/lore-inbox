Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUBSNxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUBSNwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:52:40 -0500
Received: from web12607.mail.yahoo.com ([216.136.173.230]:45324 "HELO
	web12607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267215AbUBSNwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:52:14 -0500
Message-ID: <20040219135212.34779.qmail@web12607.mail.yahoo.com>
Date: Thu, 19 Feb 2004 05:52:12 -0800 (PST)
From: Joilnen Leite <pidhash@yahoo.com>
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
