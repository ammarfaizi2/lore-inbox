Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbTDSQzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTDSQzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:55:31 -0400
Received: from web41812.mail.yahoo.com ([66.218.93.146]:32621 "HELO
	web41812.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263417AbTDSQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:55:30 -0400
Message-ID: <20030419170725.35871.qmail@web41812.mail.yahoo.com>
Date: Sat, 19 Apr 2003 10:07:25 -0700 (PDT)
From: Christian Staudenmayer <eggdropfan@yahoo.com>
Subject: 2.5.67-ac2 and lilo
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i'm running a machine that uses the aic7xxx driver for the old adaptec 2940 scsi
controller. i had problems with getting 2.5.67-ac2 to run, it used to end in
a kernel panic. i got told to remove the body of the function ide_xlate_1024
by just "return 0;", which fixed the problem, i could then boot the kernel.
but now, when running lilo, i get the following message:

Fatal: First boot sector doesn't have a valid LILO signature

these problems do not occur on kernels 2.4.20, 2.4.21-pre7-ac1 and 2.5.67-bk9,
if i boot another kernel, i can run/install LILO without problems.

i'd appreciate any insight on this problem.

Greetings, Christian Staudenmayer

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
