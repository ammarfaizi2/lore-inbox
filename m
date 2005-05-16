Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVEPPWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVEPPWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVEPPUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:20:50 -0400
Received: from web8502.mail.in.yahoo.com ([202.43.219.164]:56460 "HELO
	web8502.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261697AbVEPPL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:11:29 -0400
Message-ID: <20050516151107.62046.qmail@web8502.mail.in.yahoo.com>
Date: Mon, 16 May 2005 16:11:07 +0100 (BST)
From: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Subject: Share Wait Queue between different modules ?
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

Just trying to explore a situation where different
modules may need to share same wait queues. Could
anyone tell me the pratical situation where we need to
have above mentioned situation ?

Please clarify me on below point : 
We say that kernel stack is very much limited around
8KB.
Does all the running processes share this stack or
each process has 8KB of the space which process can
access when it is running in kernel mode.

Sharing wait queues will be difficult if the kernel
space is 8KB for all the ready processes because then
the no of wait_queue_t elements which can be added
will be limited.

Please clear my concepts over this .

Regards
Dinesh

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
