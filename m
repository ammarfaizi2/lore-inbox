Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbTJPIrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTJPIrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:47:07 -0400
Received: from [203.199.54.175] ([203.199.54.175]:55304 "EHLO
	MailRelay.lntinfotech.com") by vger.kernel.org with ESMTP
	id S262753AbTJPIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:47:05 -0400
From: "Suresh Subramanian" <Suresh.Subramanian@lntinfotech.com>
Subject: Problems in Device Driver Development
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF7B0779CA.CA76EC51-ON65256DC1.002FABA8@lntinfotech.com>
Date: Thu, 16 Oct 2003 14:15:42 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.9 |November 16, 2001) at
 10/16/2003 02:15:43 PM,
	Itemize by SMTP Server on MailRelay/LNTINFOTECH(Release 5.0.12  |February
 13, 2003) at 10/16/2003 02:30:34 PM,
	Serialize by Router on MailRelay/LNTINFOTECH(Release 5.0.12  |February 13, 2003) at
 10/16/2003 02:30:50 PM,
	Serialize complete at 10/16/2003 02:30:50 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

Me and my friends face the following problems while developing Device
Drivers.
Let me confess that we are all amateur programmers. I hope that i get a
reply for this from atleast one of the many people out there.

1.   We are not able to use copy_to_user() a chunk of memory from 'write'
function of the device driver. The pointer in the user space is passed to
the kernel space through the 'ioctl' function of the device driver.

2.    We are not able to send a signal using kill_fasync() from within a
kernel thread, to an user space process. The problem we face when we do
this is that we get an OOPS message. I tried hard to decode this message,
but in vain. So we came to the conclusion that i cannot send a signal from
within the kernel thread using kill_fasync to a process that is running in
the user space. Am i right in my conclusion, if not what should i do to
make it possible.


3.   Similar to problem numbered 2, we face same problems in doing with
'tasklets'.

Thank you.

