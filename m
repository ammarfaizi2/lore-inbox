Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTEUPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 11:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTEUPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 11:02:57 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:35305 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S262148AbTEUPC4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 11:02:56 -0400
From: Artemio <artemio@artemio.net>
To: <linux-kernel@vger.kernel.org>
Subject: HELP: kernel won't boot from /dev/sdb1
Date: Wed, 21 May 2003 18:11:22 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305211811.22994.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I've just installed RH 7.3 on a machine with all-SCSI discs. I had to load 
"linux dd" with Adaptec AIC 79xx driver floppy installed, but that's ok. 
The / is mounted from /dev/sdb1. 

So, I got a clean 2.4.20 kernel, added AIC 79xx driver sources to the kernel 
source tree, configured and compiled and installed it (of course, I didn't 
forget about the modules).

In lilo, I said "root=/dev/sdb1" just as for the original 2.4.18-3 RedHat 
kernel which boots ok.

When I boot the new kernel, I get:
VFS: Cannot open root device at "811" or "08:11"

>From SCSI-howto I got that 08:11 stands for /dev/sda11. Why would /dev/sdb1 be 
converted to 08:11 instead of 08:17 (again, corresponding to SCSI-howto)?

Would I be able to boot the kernel if I say "root=817"?

I will try tommorow when I get to that machine, but mabe you have some 
suggestions...



Thank you very much for reading all this.

Good luck!




Artemio.

