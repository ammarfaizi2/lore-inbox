Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVASHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVASHGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVASHGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:06:23 -0500
Received: from web60609.mail.yahoo.com ([216.109.119.83]:35680 "HELO
	web60609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261611AbVASHGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:06:09 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=BVZ8oSCViKGRCAGtG+llOyZ7nYTQHSqcKewHsWsVqMFL5dLTh5Y6nOKRt+/yzuUBqRh2qjpGICRUpbo7RGB0DHfuzjvhWkyxsqs8PkK0/mnYYI5vnAdJLgQ15pI7EiRTv0ZApcCPcSDKA3oFziuTvGLttQMRiqKt9rN5LRtoK7s=  ;
Message-ID: <20050119070609.38632.qmail@web60609.mail.yahoo.com>
Date: Tue, 18 Jan 2005 23:06:08 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Finding inode removal
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
     while executing pipe syscall, same inode is used
for both reading and writing. Now, if all processes
accessing the inode have terminated, the inode will be
removed. Now I am recording inode information in my
own structure in a kernel module by intercepting
syscalls. If the inode is no longer in use and if it
is removed, at that time I want to remove my record
also. How can I do that?
     Can we intercept ordinary functions defined in
kernel header files in the same way used for syscalls?
How can we do that? for eg, I want to intercept
pipe_wait function defined in pipe.c. Is it possible?

Thanks,
selva

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
