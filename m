Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVAFMSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVAFMSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVAFMSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:18:32 -0500
Received: from web60609.mail.yahoo.com ([216.109.119.83]:6034 "HELO
	web60609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262755AbVAFMSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:18:30 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=YZfxsrYmTVtAS30alWhuh/cyZ7cChY5M/Wh0mFO5rZfzHYlgqlamy4tMaVaVE9uQBCf9gvpUxEBsdpuwmgT/ZCoWwsIwht52lCl41KNu66HOJDBXe55D1hwUvVh+MgoJYFQCvIhT87pCxWerPLgP8FyCPRnXjigddIXlO4fs0fw=  ;
Message-ID: <20050106121830.44661.qmail@web60609.mail.yahoo.com>
Date: Thu, 6 Jan 2005 04:18:30 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: finding process blocking on a system call
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
   I want to find whether a process blocks in a system
call due to the unavailability of the resource that is
accessed in it. For eg, if a semaphore key is not
available to the process while executing the system
calls like read, write etc, it will wait in the
TASK_INTERRUPTIBLE state. 
   Now, I don't want the process to simply sleep,
waiting for the semaphore. I want it to be added into
the runqueue again. And also, I want to determine this
in the kernel module. How can I do this? Can anyone
help me regarding this?
 I am intercepting system calls in kernel 2.4.28.

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
