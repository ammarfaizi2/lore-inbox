Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbSJMApw>; Sat, 12 Oct 2002 20:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSJMApw>; Sat, 12 Oct 2002 20:45:52 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:60596 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261389AbSJMApu>; Sat, 12 Oct 2002 20:45:50 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Linux Kernel Development List'" <linux-kernel@vger.kernel.org>
Subject: RE: Performance improvement inquiry
Date: Sat, 12 Oct 2002 19:51:33 -0500
Message-ID: <000001c27252$b3718040$1c191c43@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

REQ: More Info needed.

What's the kernel version you're using?  Is it 2.4.19?  If not, upgrade
it.

If fact, you may want to upgrade to Red Hat Linux 8.0 due to Ext3
support that wasn't available until Red Hat Linux 7.2.  Ext3 mounted
with data=journal can offer significant performance increases for
servers with frequent I/O reads/writes over Ext2.

Is this a router?  If so, make sure to check the "Optimize as router"
box in the kernel configuration. 

ip_frag_low_thresh and ip_frag_high_thresh should be increased in some
situations.  This will allow your server to take far more connections
and put them together in memory before having to ditch their fragments.
You can safely increase these to several megabytes without any problems.

I'm sorry, but I can't answer your questions.

