Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbTIFX2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 19:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTIFX2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 19:28:12 -0400
Received: from nefty.hu ([195.70.37.175]:50816 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S262936AbTIFX2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 19:28:09 -0400
From: "Zoltan NAGY" <nagyz@nefty.hu>
To: <linux-kernel@vger.kernel.org>, <usagi-users@linux-ipv6.org>
Subject: sit tunnel/iptunnel bug?
Date: Sun, 7 Sep 2003 01:28:08 +0200
Message-ID: <FEEILOIHCEAEMLNJIDEJOELICFAA.nagyz@nefty.hu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i've got some really odd behavior.. if i do:
ip tunnel add t12 mode sit remote 195.70.51.141 local 195.70.37.175 ttl 64
then ip link set t12 up i got:
RTNETLINK answers: No such device
it must be a bug, because i only get this if i have another 12 or more
tunnels added before this one.. and just with specific ip address, if i
change it or simply use ip tunnel add t12 mode sit remote 195.70.51.141,
then it's working..
this problem exists in 2.4.20, and .22; .21 is not tested..
is this a real bug? has anyone experienced it before?

thanks,

--
Zoltan NAGY,
Network Administrator,
Nefty Informatics and Providing Ltd.,
nagyz@nefty.hu,
+36702269471

