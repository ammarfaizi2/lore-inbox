Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUJSTWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUJSTWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269726AbUJSTLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:11:12 -0400
Received: from mail.cmcvellore.ac.in ([203.145.182.9]:1236 "HELO
	mail.cmcvellore.ac.in") by vger.kernel.org with SMTP
	id S269708AbUJSTJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 15:09:04 -0400
From: Vinu Moses <vinu@cmcvellore.ac.in>
Organization: Christian Medical College, Vellore
To: linux-kernel@vger.kernel.org
Subject: System freeze on switching from X to console in 2.6.9
Date: Wed, 20 Oct 2004 00:44:08 +0530
User-Agent: KMail/1.7.1
Content-Disposition: inline
Message-Id: <200410200044.08674.vinu@cmcvellore.ac.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2004 19:07:24.0296 (UTC) FILETIME=[DDF6E880:01C4B60E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system locks up every time I try to switch from X to console using
Ctrl+Alt+x or when I log out of X. I run the system on init 3 and use
startx to get X running. Nothing but a power reset brings the system
out of it. And I'm also unable to ssh into the system from a remote box
once it locks up. The problem's reproducible with both ATI's
proprietary fglrx drivers (4.3.0-3.14.1) and the GPL'd ATI drivers 
included in X.org 6.7.0.

There are no incriminating errors in the logs on rebooting.

The problem existed in all versions of 2.6 upto 2.6.7...... seemed to be 
fixed in 2.6.8 and 2.6.8.1, both of which worked well. The problem 
seems to have resurfaced in 2.6.9.

I'm using Fedora Core 2 with all updates applied and a plain 2.6.9
kernel from www.kernel.org. The hardware's an Asus AV333 (VIA KT-333
chipset) motherboard, Athlon XP 1800+, ATI Radeon 9800Pro AGP with
128MB ram.

Looks like an AGP problem to me (wild guess), but I don't seem to have
the brains (or talent, for that matter) to figure it out any further.

Regards,
Vinu.
