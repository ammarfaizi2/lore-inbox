Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVIHQOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVIHQOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVIHQOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:14:30 -0400
Received: from f27.mail.ru ([194.67.57.195]:59653 "EHLO f27.mail.ru")
	by vger.kernel.org with ESMTP id S964877AbVIHQO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:14:29 -0400
From: Serge Goodenko <s_goodenko@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: msghdr problem in tcp_sendmsg
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.70.42]
Date: Thu, 08 Sep 2005 20:14:23 +0400
Reply-To: Serge Goodenko <s_goodenko@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1EDP2d-000Jzx-00.s_goodenko-mail-ru@f27.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I trace the kernel networking code (ver 2.4.25).
I send simple message (say, "hello") using simple client and see how tcp_sendmsg function works.
And what I see is that there's NO my message (e.g. "hello") in the msghdr structure that tcp_sendmsg receives,
e.g. in (char*)msg->msg_iov->iov_base, although debugger shows that msg->msg_iov->iov_len = 6, e.g. equals to "hello" message length (+1).
Can anyone explain where I am wrong or what I do not understand?

I am using the UML kernel and standard gdb debugger.


Serge Goodenko,
MIPT, Russia
