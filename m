Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVCII4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVCII4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 03:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVCII4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 03:56:47 -0500
Received: from web60605.mail.yahoo.com ([216.109.118.243]:9875 "HELO
	web60605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261640AbVCII4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 03:56:46 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=5yXIsKTfpgzogKXQa2mn9ocRKubgFRltABFT+GgPwYwuUVkIrxZysnTh9neAcmLbc4+jb+Aa+5kGUbxydg+99hIUuSAHIbJ8EEPXUh0jCL6Foo26jg/6GCYoR+mUrbL5SejYl/KR+WtgeUTQrMX4wOJfGEen2GIxnnPL0sV7SPA=  ;
Message-ID: <20050309085645.46998.qmail@web60605.mail.yahoo.com>
Date: Wed, 9 Mar 2005 00:56:45 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: problem in adding a new element to task_struct
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I want to add a linked list member(list_head) to
the task_struct data structure in kernel 2.4.28 for my
personal work. When I added them without initializing
them in INIT_TASK, no problem occurred. But when I
initialized the linked list member using
LIST_INIT_HEAD the kernel stops in POSIX
initialization phase and it never proceeds after that.
What should I take into account when adding my member
to the task_struct? What could be the problem?

Regards & thanks in advance,
selva


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
