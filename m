Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSJMTGY>; Sun, 13 Oct 2002 15:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSJMTGX>; Sun, 13 Oct 2002 15:06:23 -0400
Received: from 12-221-42-172.client.insightBB.com ([12.221.42.172]:3456 "EHLO
	theretriever.org") by vger.kernel.org with ESMTP id <S261337AbSJMTGX>;
	Sun, 13 Oct 2002 15:06:23 -0400
Date: Sun, 13 Oct 2002 14:11:58 -0500 (CDT)
From: solrosin@mail.theretriever.org
To: linux-kernel@vger.kernel.org
Subject: Problem with ide-scsi kernel module
Message-ID: <Pine.LNX.4.44.0210131410120.2020-100000@theretriever.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would appear that there is a problem in the ide-scsi kernel module.  I 
HAVE properly built the kernel beforehand, so I know it's not a matter of 
the kernel being improperly built.  Here's the error message I'm getting 
when I try to insmod ide-scsi:
 
Using /lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o
/lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o: unresolved symbol 
scsi_unregister_module_R81d85a75
/lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o: unresolved symbol 
scsi_register_Rfb1392b2
/lib/modules/2.4.19/kernel/drivers/scsi/ide-scsi.o: unresolved symbol 
scsi_register_module_Rfa20b7b0
 
 
This is the only module that is doing this, so it's an isolated incident.  
The problem is that I need to use ide-scsi to use my CD writer.  Is there 
a patch for this, or am I doing something wrong that I didn't know about?  
The version of gcc I'm using is "gcc version 2.96 20000731 (Red Hat Linux 
7.3 2.96-110)".  Let me know what you think.  Thanks.


