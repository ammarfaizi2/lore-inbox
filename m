Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVDPOOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVDPOOn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 10:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVDPOOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 10:14:43 -0400
Received: from web52210.mail.yahoo.com ([206.190.39.92]:24415 "HELO
	web52210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262666AbVDPOOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 10:14:42 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ttw1YexG8SOJCyNqLcHVnPt95gQXvGtRz3Fse2ds2fGolYgxjZxT9bksAlr6Bwd39Tg1CwBqKAtZC0dIMb7RaVacqWaLC0CGJj/GKpLVbQWnBxYv+z1IQhTUbVtEiWJ0lJM/6biJ5WHoi1YJSxgja7qch6+G/9GUKXQX7/7aZFw=  ;
Message-ID: <20050416141442.51250.qmail@web52210.mail.yahoo.com>
Date: Sat, 16 Apr 2005 07:14:41 -0700 (PDT)
From: linux lover <linux_lover2004@yahoo.com>
Subject: kfree_skb gives oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
     I am checking some conditions in packet after IP
header is removed and based on that want network stack
to discard skbuff so i add it in ip_input.c . 
       But it gives oops message that 
Warning: kfree_skb passed an skb still on a list and
then prints oops 
       Please help how to do that and correct me to
use a way by which i will not face any kernel panic
message? 
Thanks in advance.
regards,
linux_lover.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
