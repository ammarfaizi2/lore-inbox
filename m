Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVKAS7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVKAS7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVKAS7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:59:09 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:7074 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751115AbVKAS7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:59:08 -0500
Message-ID: <035101c5df17$223eccb0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: cpuset - question
Date: Tue, 1 Nov 2005 20:02:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list

I have tried this:

[root@dy-xeon-1 dev]# mount -t cpuset none /dev/cpuset
[root@dy-xeon-1 dev]# cd /dev/cpuset
[root@dy-xeon-1 cpuset]# mkdir cpus_0
[root@dy-xeon-1 cpuset]# cd cpus_0
[root@dy-xeon-1 cpus_0]# /bin/echo 0 > cpus
[root@dy-xeon-1 cpus_0]# /bin/echo 1 > mems
/bin/echo: write error: Numerical result out of range
[root@dy-xeon-1 cpus_0]# echo 1 >mems
[root@dy-xeon-1 cpus_0]# cat mems

[root@dy-xeon-1 cpus_0]# /bin/echo $$ > tasks
/bin/echo: write error: No space left on device
[root@dy-xeon-1 cpus_0]# echo $$ >tasks
[root@dy-xeon-1 cpus_0]# cat tasks
[root@dy-xeon-1 cpus_0]#

The google, and man pages cant help.
What can i do?

Thanks

Janos
