Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVBWUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVBWUlr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVBWUlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:41:47 -0500
Received: from kunet.com ([69.26.169.26]:47368 "EHLO kunet.com")
	by vger.kernel.org with ESMTP id S261565AbVBWUlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:41:45 -0500
Message-ID: <009d01c519e8$166768b0$7101a8c0@shrugy>
From: "Ammar T. Al-Sayegh" <ammar@kunet.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at mm/rmap.c:483!
Date: Wed, 23 Feb 2005 15:41:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I recently installed Fedora RC3 on a new server.
The kernel is 2.6.10-1.741_FC3smp. The server
crashes every few days. When I examine /var/log/messages,
I find the following line just before the crash:

Feb 22 23:50:35 hostname kernel: ------------[ cut here ]------------
Feb 22 23:50:35 hostname kernel: kernel BUG at mm/rmap.c:483!

No further debug lines are given to diagnose the
source of the problem.

I have been using kernel 2.4 for few years now without
any problem. This is the first time I see this problem
with kernel 2.6. I'm not sure if this is related to
the kernel itself, the new hardware, or some other
installed software. I'm thinking about downgrading to
kernel 2.4. Do you think this will resolve this issue?
Any suggestion on what else I can do to mitigate this
problem?

Thanks.


-ammar
