Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUALLO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 06:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUALLO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 06:14:27 -0500
Received: from tataelxsi.co.in ([203.197.168.150]:30476 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S266145AbUALLOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 06:14:23 -0500
Reply-To: <vijayabhaskar@tataelxsi.co.in>
From: "VIJAYABHASKAR" <vijayabhaskar@tataelxsi.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Atul V Kulkarni" <atulk@tataelxsi.co.in>,
       "Arvind Kumar" <akumar@tataelxsi.co.in>
Subject: Very Urgent !! (2'nd Post)  Not able to recieve messages using sock_recvmsg()
Date: Mon, 12 Jan 2004 16:41:33 +0530
Message-ID: <003c01c3d8fc$d7411230$501e010a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-HI All,
-I am not able to recieve messages using sock_recvmsg()
-Server running on TCP port in kernel space and client is in  user space.
Client is sending the messages and server recieving them and no error
observed while recieving.
But i couldn't able to get the messages
This is the code i am using
 msg.msg_name = NULL;
msg.msg_namelen = 0;
msg.msg_iov = &iov;
msg.msg_iovlen = 1;
msg.msg_control = NULL;
msg.msg_controllen = 0;
msg.msg_flags = 0
len = 0
 len = sock_recvmsg(newsock, &msg, (size_t)buf, 0)
printk( KERN_ALERT "recieved message is %s",buf)
But not printing the content of buffer.
Any help in this regard is highly appreciated
Thanks
Bhaskar

