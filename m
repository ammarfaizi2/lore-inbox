Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTD2NZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTD2NZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:25:53 -0400
Received: from [63.246.199.14] ([63.246.199.14]:30879 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S262002AbTD2NZw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:25:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: linux-kernel@vger.kernel.org
Subject: software reset
Date: Tue, 29 Apr 2003 10:37:13 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304291037.13598.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone tell me how to absolutely force a reset on a i386?  Specifically, 
is there a system call that will call the assembly instruction to assert the 
RESET bus line? I try to use the "reboot(LINUX_REBOOT_CMD_RESTART,0,0,NULL)" 
call, but it will not always work.  Occassionally, I experience a "missed 
interrupt" on a Promise IDE controller, and while I can telnet into the 
system, I can't reset it.  Any help greatly appreciated!  Since these systems 
are 1000's of miles away, the need to remotely reset it paramont.


-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
