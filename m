Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUIKS7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUIKS7E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUIKS7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:59:04 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:37764 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268281AbUIKS7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:59:00 -0400
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Subject: kernel execution not deterministic
Date: Sat, 11 Sep 2004 16:02:41 -0300
User-Agent: KMail/1.6.2
Cc: ramosf@cos.ufrj.br
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111602.41169.ramos_fabiano@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I wrote a module to trace the instructions executed by the kernel
to service a system call. Its just a eflags setting bit at the start of
the syscall handler and a debug handler that increments a counter.

The thing is that the syscalls are sometimes taking more or less
instructions to execute. Why is that? Is it expected? Or a probably
made a mistake?


TIA,
Fabiano
