Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTFLJXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTFLJXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:23:53 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:16261 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S264472AbTFLJXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:23:51 -0400
Message-ID: <1055410660.3ee849e439b96@support.tuxbox.dk>
Date: Thu, 12 Jun 2003 11:37:40 +0200
From: Martin List-Petersen <martin@list-petersen.dk>
To: linux-kernel@vger.kernel.org
Cc: kernel@gotontheinter.net
Subject: implicid declaration of function task_suspended - Was: [PATCHSET] 2.4.21-rc6-dis3 released
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile this (both on rc6 and rc7) and the compile fails with:

kernel/kernel.o(.text+0x2d8): In function 'schedule':
: undefined reference to 'TASK_SUSPENDED'
kernel/kernel.o(.text+0x392): In function 'schedule':
: undefined reference to 'TASK_SUSPENDED'

The compile allready stated in the beginning:
sched.c: In function 'schedule':
sched.c:611: implicit declaration of function 'TASK_SUSPENDED'

Any idea's what i can leave out to avoid these failures ?

Regards,
Martin List-Petersen
martin at list-petersen dot dk
--
Q:	What do you get when you cross the Godfather with an attorney?
A:	An offer you can't understand.

