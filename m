Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbULUCqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbULUCqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 21:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbULUCqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 21:46:43 -0500
Received: from web52608.mail.yahoo.com ([206.190.39.146]:12455 "HELO
	web52608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261297AbULUCqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 21:46:37 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Whv9dH4n0b0d+Kp6WNhD5T550pI+Pu1QllG+vr+4kGrMs4PzfKrmyPdu7ohULBNPftg5gAYQhtngD6pwErqUx0w0W0ORmXYJYpTGAJmGrdTSJ2HMQe8PZ3hn0ml4Td3TU/srLAMRuAeG7/Ho2DMlOKk4MtUlfV7oygpsKv/rbCQ=  ;
Message-ID: <20041221024637.69003.qmail@web52608.mail.yahoo.com>
Date: Mon, 20 Dec 2004 18:46:37 -0800 (PST)
From: jesse <jessezx@yahoo.com>
Subject: a wierd /proc shared mem number
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
hi, one of my application gets wierd /proc/xxx/statm
information , 

[root@sa-cm2-7 proc]# cat /proc/2242/statm 
9408 7574 4294966664 4294966307 5983 2580 94 

please advice what is wrong ? why I get the bizzar
numbers in the 3rd and 4th parameter? 

here is the system information: 
[root@sa-c2-9 root]# uname -a 
Linux sa-c2-9 2.4.21-15.ELsmp #1 SMP Thu Apr 22
00:18:24 EDT 2004 i686 i686 i386 GNU/Linux 

[root@sa-c2-9 root]# top -v 
procps version 2.0.13 

thanks you in advance! 
