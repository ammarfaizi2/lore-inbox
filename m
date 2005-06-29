Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVF2RdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVF2RdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVF2Rcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:32:33 -0400
Received: from alog0025.analogic.com ([208.224.220.40]:2728 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262294AbVF2R3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:29:03 -0400
Date: Wed, 29 Jun 2005 13:28:22 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: sys_call_table in read-only section
Message-ID: <Pine.LNX.4.61.0506291313190.4982@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I noticed a patch this AM to put the syscall_table in with read-only
data. I didn't save the patch, but I put the sys_call_table in
.section .rodata. System.map shows that it's there. Tests show that 
the sys_call_table, even though in the so-called R/O section can
still be written. Is there a special R/O section that will truly
prevent kernel (driver) code from writing?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
