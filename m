Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVEIFAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVEIFAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 01:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVEIFAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 01:00:44 -0400
Received: from web60518.mail.yahoo.com ([209.73.178.166]:43423 "HELO
	web60518.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263045AbVEIFAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 01:00:39 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=sGKuFIxScuASzT97pG21OejevHYFlga4cfq8gHLwnPWZWp6yAujXeK2Osskq3asm6qSaBoKeO6HkeHD/aNMtvr2QOYKhSGASeCXWRqRV/4PnjersG9DPTnxoCi6H7IleON3dkvU763io4dQGvmzEthc+walg+3C3zmW/by3eC0U=  ;
Message-ID: <20050509050035.86058.qmail@web60518.mail.yahoo.com>
Date: Sun, 8 May 2005 22:00:34 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: NPTL: pid of a thread and gdb
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the NPTL ilbrary to create a thread.
In NPTL the parent and the thread have the same pid.
Then on what basis gdb differentiates between the
threads which have the same pid ?
gdb gives following message when it encounters a
pthread_create() statement:

[New Thread 1075138688 (LWP 7034)]
[New Thread 1077242800 (LWP 7037)]

the LWP 7034 is the pid of parent process (in this
case LWP is same as pid).
from where does it calculate LWP 7037 for the thread ?
(in this case LWP is different from pid, pid for the
thread is still 7034)

-lnxluv


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
