Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbTICUBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTICT7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:59:35 -0400
Received: from 154.Red-80-33-156.pooles.rima-tde.net ([80.33.156.154]:42986
	"EHLO banzais.org") by vger.kernel.org with ESMTP id S264435AbTICT61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:58:27 -0400
Subject: Strange debug message from 2.6test kernel: 'sleeping function
	called from invalid context...'
From: axel c <axel@banzais.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062630614.5127.7.camel@mao.ikp.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 22:10:15 -0100
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 212.170.14.92
X-Return-Path: axel@banzais.org
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been using the 2.6.0-0.test4.1.32 RedHat kernel for a week now with
no problems. However, when i came back from work today i found the
following message from kernel after doing 'dmesg':

Debug: sleeping function called from invalid context at
include/asm/uaccess.h:473
Call Trace:
 [<c011afed>] __might_sleep+0x5d/0x70
 [<c010d0ea>] save_v86_state+0x6a/0x200
 [<c010c8b5>] do_IRQ+0xd5/0x110
 [<c010acd2>] work_notifysig_v86+0x6/0x14
 [<c010ac7f>] syscall_call+0x7/0xb

The system has not crashed or anything, everything is fine, but i just
wanted to point this out in case it may be of interest for kernel
developers. Unfortunately this msg seems to have been emitted while i
was away, so i can't give more detailed info about the conditions in
which happened. All i can say is the box was basically idle, just
running X with a couple of terminals and the screensaver.
Sorry in advance if this message is just a piece of useless rubbish, i
know basically nothing about kernel internals.

PS: I am not subscribed to the list, please CC me when answering.

Thanks, 



-- 
axel c <axel@banzais.org>


