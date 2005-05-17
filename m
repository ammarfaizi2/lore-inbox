Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVEQLZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVEQLZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVEQLYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:24:31 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:63874 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S261397AbVEQLTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:19:54 -0400
Message-ID: <000b01c55ad2$5acaf690$0101010a@dioxide>
From: "linux" <kernel@wired-net.gr>
To: <linux-kernel@vger.kernel.org>
References: <2538186705051703441093903a@mail.gmail.com>
Subject: 2.6 kernel network programming
Date: Tue, 17 May 2005 14:19:56 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
can someone tell me how i can listen and accept connections into a port from
the kernel-space???
I start listening with the following function :

        struct socket *sock;
        struct sockaddr_in sin;
        int error=0;

        error=sock_create(PF_INET,SOCK_STREAM,IPPROTO_TCP,&sock);

        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = INADDR_ANY;
        sin.sin_port = htons((unsigned short)port);

        error=sock->ops->bind(sock,(struct sockaddr*)&sin,sizeof(sin));
        sock->ops->listen(sock,48);

How about accepting connections and sending some kind of a message for
beggining?
Can someone help me please.


Thanks in advance,
chris.

