Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTENPGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTENPGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:06:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:7810 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262412AbTENPGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:06:52 -0400
Date: Wed, 14 May 2003 06:05:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 717] New: Laptop keyboard doesn't work 
Message-ID: <1680000.1052917533@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Laptop keyboard doesn't work
    Kernel Version: 2.5.69 and 2.5.69-bk8
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: fxkuehl@gmx.de


Distribution: Debian (Sarge)
Hardware Environment:

Laptop, AMD mobile Athlon XP 2000+
VIA Technologies, Inc. P/KN266 Host Bridge
No external keyboard connected (the thing doesn't even have a PS/2 connector).
Please let me know if there is any more useful information I can supply.

Software Environment:
Problem Description:

I can boot the kernel, but I can't input anything on the keyboard. I'm pretty
sure that this is not due to a bad configuration. I read the post-halloween-2.5
doc and some related bug reports. Here are the relevant parts from my .config:

CONFIG_INPUT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y

I enabled DEBUG in i8042.c. I'll add the output (with 2.5.69-bk8) from kern.log
as an attachment.

Steps to reproduce:

Boot the system ;-)

