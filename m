Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263476AbTDNPf4 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTDNPf4 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:35:56 -0400
Received: from web12103.mail.yahoo.com ([216.136.172.23]:8332 "HELO
	web12103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263476AbTDNPfy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 11:35:54 -0400
Message-ID: <20030414154743.83419.qmail@web12103.mail.yahoo.com>
Date: Mon, 14 Apr 2003 08:47:43 -0700 (PDT)
From: Christian Staudenmayer <the_sithlord@yahoo.com>
Subject: 2.5.67-ac1 kernel panic
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

the 2.5.67 kernel boots fine here, but the -ac1 patch to it ends up in a kernel panic.
i'll just post the last few lines of the error here, because i had to type it myself on another
machine:

[<c0273589>] sd_attach+0x1d/0x244
[<c023d9c0>] scsi_register_device+0xb8/0xe4
[<c010502c>] init+0x0/0x144
[<c0105049>] init+0x1d/0x144
[<c010502c>] init+0x0/0x144
[<c01079c1>] kernel_thread_helper+0x5/0xc

Code: 8b 40 38 be 93 74 31 c0 ff d0 89 c1 c7 03 3f 00 00 00 85 ff
 <0>Kernel panic: Attempted to kill init!

(if it's necessary i can get the whole screenfull of errors)

The machine is a p3 700 with 448MB of ram, and it's running an old scsi disk at an adaptec 2940
controller that uses the aic7xxx drivers (at boot it says AIC7870).
When configuring (make menuconfig) the kernel, i loaded the saved config file that worked for
2.5.67.

Note: i am not subscribed to the lkml, perhaps i will later on, when i'm more experienced.
so, please email me at the_sithlord@yahoo.com
you can also drop by in my undernet channel called #hansapils

any help regarding this problem would be highly appreciated.

greetings, chris
the_sithlord@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
