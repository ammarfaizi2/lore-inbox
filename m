Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUAIQKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAIQKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:10:49 -0500
Received: from web21204.mail.yahoo.com ([216.136.131.77]:9363 "HELO
	web21204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261877AbUAIQKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:10:47 -0500
Message-ID: <20040109161047.46078.qmail@web21204.mail.yahoo.com>
Date: Fri, 9 Jan 2004 08:10:47 -0800 (PST)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: kernel 2.4.24 - weird priorities for RAID processes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The 2.4.24 kernel reports weird priorities for
certain processes.


kiev:~>cat /proc/version
Linux version 2.4.24 (root@kiev.somewhere.EDU) (gcc
version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP
Thu
Jan 8 16:47:09 EST 2004


  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM
  TIME CPU COMMAND
    6 root       9   0     0    0     0 SW    0.0  0.0
  0:00   0 bdflush
    7 root       9   0     0    0     0 SW    0.0  0.0
  0:00   0 kupdated
    8 root     18446744073709551615 -20     0    0    
0 SW<   0.0  0.0   0:00   1 mdrecoveryd
   16 root     18446744073709551615 -20     0    0    
0 SW<   0.0  0.0   0:00   0 raid1d





__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
