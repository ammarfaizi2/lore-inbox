Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSIOCwE>; Sat, 14 Sep 2002 22:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSIOCwE>; Sat, 14 Sep 2002 22:52:04 -0400
Received: from [64.246.18.23] ([64.246.18.23]:36834 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S317673AbSIOCwD> convert rfc822-to-8bit;
	Sat, 14 Sep 2002 22:52:03 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: "'Michal Kochanowicz'" <michal@michal.waw.pl>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: rmmod ip_conntrack locks
Date: Sat, 14 Sep 2002 21:57:35 -0500
Message-ID: <000601c25c63$a81150e0$1401a8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20020914223726.GC12639@wieszak.mmm.ozarow-12.waw.pl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,
	I don't have an answer for why this happens, but you can compile
ip_conntrack into your kernel as a possible work around.  I did this to
prevent this version issue.

Steve


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Michal
Kochanowicz
Sent: Saturday, September 14, 2002 5:37 PM
To: Linux Kernel Mailing List
Subject: rmmod ip_conntrack locks

Hi

I'm using plain 2.4.19 on small router with masquerade. Every time I try
to remove ip_conntrack from memory process hangs. It can't be kill -9.
Please let me know what kind of information can be useful to trace this
problem.

I've found in archives that person reporting similar problem some time
ago was asked to show result of ps lax. So here it is:
100     0 13622 12852  14   0  1484  432 -      R    pts/0      3:08
rmmod ip_co

Regards
-- 
--= Michal Kochanowicz =--==--==BOFH==--==--= michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


