Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289619AbSAWWsA>; Wed, 23 Jan 2002 17:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289925AbSAWWqd>; Wed, 23 Jan 2002 17:46:33 -0500
Received: from ns1.jasper.com ([64.19.21.34]:46826 "EHLO ersfirep1")
	by vger.kernel.org with ESMTP id <S289619AbSAWWqH>;
	Wed, 23 Jan 2002 17:46:07 -0500
From: "Radivoje Todorovic" <radivojet@jaspur.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Netlink
Date: Wed, 23 Jan 2002 16:45:04 -0600
Message-ID: <BOEOJGNGENIJJMAOLHHCGELJDCAA.radivojet@jaspur.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Not sure if this is the right list to ask this question....

While I was trying to evaluate what is the best method to get the data from
Kernel-Space to User-Space and vice-versa I found that two techniques are
available:

-IOCTL
-Netlink Sockets



I would like to know which one would be used in what situation?
Is there a (buffer, message)data size limit for the those two?

Seems that if one wants to get data from the kernel which is triggered by
some interupt IOCTL cannot be used as IOCTL is invoked  from the User-Space
while netlink socket can listen for the kernel event to take place and then
simply read from the socket. Correct?


The other issue is that user-space part of Netlink socket is trivial to use
while kernel part is nightmare. So I would appreciate any help if someone
can send me sample module that both sends and receives "Hello" message
to/from the Netlink Socket

Rade

