Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTE0Wcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTE0Wcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:32:32 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:16342 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S264407AbTE0Wca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:32:30 -0400
Date: Wed, 28 May 2003 02:00:06 +0200
From: Nir Livni <nir_l3@netvision.net.il>
Subject: fork() returns on parent but not returns on child
To: linux-kernel@vger.kernel.org
Cc: Nir Livni <nirl@cyber-ark.com>
Reply-to: Nir Livni <nirl@cyber-ark.com>
Message-id: <00f801c324ac$1904b6a0$30dfda51@pinguin>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am experiencing a problem, where fork() returns succesfully on parent, but
does not return on child.
The child process simply "disappears".
I believe it might have got a SIGSEGV (if it makes any sence) before fork()
has returned.

I would like to track down this problem.
What I did so far is:
1. I tried first to make sure there are no memory overruns using few tools.
2. I tried to look at strace output, but the problem does not occur if I use
strace
3. I make a UserModeLinux machine
and now I would like to breakpoint the created child before it crashes
(assuming it really crashes)

How do I do that ?

Thanks,
Nir

