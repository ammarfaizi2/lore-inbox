Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVALGlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVALGlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 01:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVALGlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 01:41:05 -0500
Received: from web60608.mail.yahoo.com ([216.109.119.82]:63577 "HELO
	web60608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261257AbVALGlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:41:00 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=XC7997mh/m5fWs9sHCewP6CSkKhLnBpKiAcqG78u4uwGaUTtENbTKB/Q4cZH9tCNQHKSWH+Jk6dYAgRP/EEx+z695XC/JVPI+Gm0hfWh4JiRJOFZnsectSwZUPF8MWZVipCoog6iaVbFRIWOFCm3hAm6uK3H6yFXar04dyJXSM8=  ;
Message-ID: <20050112064059.72521.qmail@web60608.mail.yahoo.com>
Date: Tue, 11 Jan 2005 22:40:58 -0800 (PST)
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
