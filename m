Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132735AbRC2Lte>; Thu, 29 Mar 2001 06:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132723AbRC2LtY>; Thu, 29 Mar 2001 06:49:24 -0500
Received: from mail22.bigmailbox.com ([209.132.220.199]:5125 "EHLO
	mail22.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S132714AbRC2LtH>; Thu, 29 Mar 2001 06:49:07 -0500
Date: Thu, 29 Mar 2001 03:48:20 -0800
Message-Id: <200103291148.DAA28629@mail22.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [12.40.232.3]
From: "Deja User" <amarnder@my-deja.com>
To: linux-kernel@vger.kernel.org
Subject: question on ip_masq_irc.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am working on a NAT product and trying provide mIRC support in it. I am looking into ip_masq_irc.c file of Linux 2.2.12 for reference, and have some doubts.
1. In 2.2.12 ip_masq_irc.c, DCC RESUME protocol is not supported. In which patch can I find it?
2. I have pre-patch-2.2.18-5 linux.18p5/net/ipv4/ip_masq_irc.c, which has support for DCC RESUME. Is this the final patch? I have checked with documentation in mIRC help files about DCC RESUME command string. It says the command string in the pay load looks 
   DCC RESUME filename port position
   But, in the above file, the string hunted is 
   "\1DCC RESUME chat AAAAAAAA P\1\n"

Can anybody please clarify, what exactly should be searched?

thanks in advance
--Amar







------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


