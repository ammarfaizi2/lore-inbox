Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUHaRLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUHaRLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUHaRJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:09:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264953AbUHaRIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:08:51 -0400
Date: Tue, 31 Aug 2004 13:08:39 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.8.1-ac1
Message-ID: <20040831170839.GA18799@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted up a 2.6.8.1-ac1. This is mostly aimed at people wanting to try
the newer IDE stuff while I work on feeding it to Bartlomiej. 

http://www.kernel.org/pub/linux/kernel/people/alan/2.6/linux-2.6/2.6.8.1/..

Change summary for Linux 2.6.8.1-ac1 versus 2.6.8.1

[ * = submitted to maintainer, + = submitted but needs more work ]

*	Fix crash on boot or nonworking keyboard driver		(Alan Cox)
		with E750x based systems in SMP
*	Fix timing violation in i8042 driver code		(Alan Cox)
*	Allow 3% slack for root in strict overcommit		(Alan Cox)
*	Add support for 16byte (GPRS) pcmcia serial cards	(Alan Cox)
*	Reformat buslogic ready for real fixing			(indent)
*	Support VLAN on 3c59x/3c90x hardware		(Stefan de Konkink)
*	Serial ATA reporting of ATA errors for real diagnostics	(Alan Cox)
+	Fix IDE locking, /proc races and other uglies		(Alan Cox)
+	Initial IT8212 IDE driver				(Alan Cox)
+	IDE hotplug (controller level)				(Alan Cox)
+	Fix IDE disk crash on bad geometry			(Alan Cox)
+	Fix mishandling of pure LBA devices			(Alan Cox)
+	Fix problems with non-decoded slaves			(Alan Cox)
-	Fix failure to handle large drives on ALi controllers	(Alan Cox)
	| Lost from 2.4-ac to 2.6.
-	Initial code working at making jiffies removal easier	(Alan Cox)

