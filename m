Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUALKIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266123AbUALKIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:08:36 -0500
Received: from tataelxsi.co.in ([203.197.168.150]:47372 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S266119AbUALKIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:08:34 -0500
Reply-To: <vijayabhaskar@tataelxsi.co.in>
From: "VIJAYABHASKAR" <vijayabhaskar@tataelxsi.co.in>
To: <linux-kernel@vger.kernel.org>
Subject: Not able to recieve messages using sock_recvmsg()
Date: Mon, 12 Jan 2004 15:35:48 +0530
Message-ID: <003301c3d8f3$a7b0cbe0$501e010a@telxsi.com>
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
-Server running on TCP port in kernel space and client is in ser space. 
-sending messages to the server, i didn't see any message from client.
-but there is no error while connecting to the server
-This is the code i am using
- msg.msg_name = NULL;
-msg.msg_namelen = 0;
-msg.msg_iov = &iov;
-msg.msg_iovlen = 1;
-msg.msg_control = NULL;
-msg.msg_controllen = 0;
-msg.msg_flags = 0
-len = 0
- len = sock_recvmsg(newsock, &msg, (size_t)buf, 0)
- printk( KERN_ALERT "recieved message is %s",buf)
-But not printing the content of buffer.
-Any help in this regard is highly appreciated
-Thanks
-Bhaskar

