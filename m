Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUDOKCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUDOKCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:02:47 -0400
Received: from www.gawab.com ([204.97.230.36]:27400 "HELO gawab.com")
	by vger.kernel.org with SMTP id S261183AbUDOKCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:02:46 -0400
Subject: Interrupt handler
From: MNH <tuxracer@gawab.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082023366.3953.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Apr 2004 15:32:46 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I have a general question.

If a process is executing a system call, and an interrupt is invoked,
the process blocks. Now since interrupt handlers cannot block, the time
for which the IH runs is taken out of the process's time-slice ( Is this
right ?).

What if the IH takes up all of the process's time-slice, does the
process gets knocked off the current list and thrown into the expired
list or is there something more to it?

thanks for your time

