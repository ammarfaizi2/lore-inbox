Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUHOVoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUHOVoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUHOVoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:44:05 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:16091 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266917AbUHOVn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:43:56 -0400
Message-ID: <411FD919.9030702@comcast.net>
Date: Sun, 15 Aug 2004 14:43:53 -0700
From: John Wendel <jwendel10@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1 Mis-detect CRDW as CDROM
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1. 
Booting back into 2.6.7 corrects the problem. I've attached the (totally 
uninteresting parts of) dmesg.  Any clues  appreciated.

Linux version 2.6.7-1.494.2.2 (bhcompile@tweety.build.redhat.com) (gcc 
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Tue Aug 3 09:39:58 
EDT 2004
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

Linux version 2.6.8.1 (jwendel@xxxxxxxxx) (gcc version 3.3.3 20040412 
(Red Hat Linux 3.3.3-7)) #1 Sun Aug 15 10:50:07 PDT 2004
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20


