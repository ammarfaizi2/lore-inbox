Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266701AbUAWUIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266690AbUAWUHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:07:02 -0500
Received: from [62.38.242.193] ([62.38.242.193]:40644 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S266696AbUAWUFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:05:53 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: atkbd w 2.6.2rc1 : HowTo for extra (inet) keys ?
Date: Fri, 23 Jan 2004 22:04:27 +0200
User-Agent: KMail/1.6
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401232204.27819.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again.
I just reverted my atkbd.c code to your version (Linus's tree) and 
unfortunately have 4 keys 'missing' from my HP Omnibook XE3GC extra "internet 
keys".
Question 1: Can I fix the table from userland, using some utility? That is, 
can I upload an updated table into the kernel, so that I don't have to 
reboot?
Q 2: Do you have any HowTo/QA for that?
Q 3: Will that work under X? (which AFAIK reads the 'raw' codes)
Q 4: It has been rather difficult for me to compute the scancodes needed for 
the table. Could you put the "formula" onto the HowTo?

Thanks.

FYI, the codes are:
"www": Unknown key pressed (translated set 2, code 0xf3 on isa0060/serio0).
"Mail":  Unknown key pressed (translated set 2, code 0xf4 on isa0060/serio0).
"Launch": Unknown key pressed (translated set 2, code 0xf2 on isa0060/serio0).
"Help":  Unknown key pressed (translated set 2, code 0xf1 on isa0060/serio0).
