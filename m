Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316974AbSE1WKK>; Tue, 28 May 2002 18:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316975AbSE1WKJ>; Tue, 28 May 2002 18:10:09 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:24331 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S316974AbSE1WKI>; Tue, 28 May 2002 18:10:08 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <03781128C7B74B4DBC27C55859C9D7380984062E@es06snlnt>
From: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: module question
Date: Tue, 28 May 2002 16:10:06 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 10ED206F6958041-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been assigned to a project where we are trying to fool
OS footprinters into thinking the machine is running another
OS. I was thinking I could write a module which registers
a packet handler to modify the TCP/IP headers as necessary.
I haven't really looked into this all much.

I would like to be able to have some sort of user-space
GUI that the root user could run to allow for dynamic
configuration of the module. My question is: what would be
the best way to go about this? Should I keep the current
config of the module inside /proc so that way both the
GUI has access to it and the module has instantaneous
access to it without having to be reloaded?

I would like to avoid patching the kernel and just keeping
it to a module. However, any tips or advice that anyone
can provide would be most helpful.

BTW, if you could CC any answers to me, I'd appreciate
it as I'm not subscribed to the list.

Thanks in advance for your wisdom,

Jeff Shipman - CCD
Sandia National Laboratories
(505) 844-1158 / MS-1372


