Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVALEDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVALEDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 23:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVALEDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 23:03:15 -0500
Received: from web60609.mail.yahoo.com ([216.109.119.83]:25939 "HELO
	web60609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262835AbVALEDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 23:03:13 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ngQ4rAAFYwIuhkD9uoNzKdMQbQSADR0y+KiMsUvNHjzQBp8sLc394BXzRDkSbCfYYo/is/iPU8zB+k5swUCGzsigRfBfZkzvhGoX+p3l9+2/ZwhwTEz5r9/Pp7/14/ZaUoeW0RZnx3ZhFlSWrDpLxdkWsnOdz530D+0v7ELjCy4=  ;
Message-ID: <20050112040312.44853.qmail@web60609.mail.yahoo.com>
Date: Tue, 11 Jan 2005 20:03:12 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Making sys_read to operate only on pipefs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
   I am intercepting syscalls in kernel 2.4.28. I want
to intercept read system call for the pipefilesystem.
Ofcoure read is a more generic syscall. But while
intercepting it, I have to determine whether this one
operates on a pipe. If it is, I want to perform some
other work, else nothing should be done and the normal
work has to be performed.For this, can I compare the
read function pointer in file operation structure with
the function pipe_read prototype in pipe.c. Is it
possible? If not how can I do that?

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
