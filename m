Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTJPQEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTJPQEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:04:04 -0400
Received: from [203.199.54.175] ([203.199.54.175]:32268 "EHLO
	MailRelay.lntinfotech.com") by vger.kernel.org with ESMTP
	id S263005AbTJPQEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:04:02 -0400
From: "Suresh Subramanian" <Suresh.Subramanian@lntinfotech.com>
Subject: asynchronous notification
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF9B35F107.723858B5-ON65256DC1.0056E5A9@lntinfotech.com>
Date: Thu, 16 Oct 2003 21:32:45 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.9 |November 16, 2001) at
 10/16/2003 09:32:45 PM,
	Itemize by SMTP Server on MailRelay/LNTINFOTECH(Release 5.0.12  |February
 13, 2003) at 10/16/2003 09:47:37 PM,
	Serialize by Router on MailRelay/LNTINFOTECH(Release 5.0.12  |February 13, 2003) at
 10/16/2003 09:47:48 PM,
	Serialize complete at 10/16/2003 09:47:48 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

i have a problem sending signals from kernel thread using kill_fasync( ) to
an user space process which has registered to the device driver through
fcntl( ) for asynchronous notification. I assume this is due to the
difference in the context from kernel process (to which the user process
has registered) to the kernel thread .

So i decided to use kill_proc( ) to send a signal from the kernel thread.
Since i m using kill_proc( ) i m not registering any process for
asynchronous notification and i m doing this registration manually  by
geting the necessary information like 'pid', 'fd' etc...and maintaining
this info.This method works perfectly fine.

Please let me know if there is any drawback in this non-conventional
method.
Please give me details in either case.

Thank you.

Suresh S

