Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277325AbRJLSd3>; Fri, 12 Oct 2001 14:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277348AbRJLSdT>; Fri, 12 Oct 2001 14:33:19 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:47115 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S277325AbRJLSdC>; Fri, 12 Oct 2001 14:33:02 -0400
Message-ID: <002401c1534c$83f47320$6401000a@it0>
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: network kernel options
Date: Fri, 12 Oct 2001 20:34:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just switched from 2.2.19pre7 to 2.4.10-ac11.

I had this line before appended to lilo

append="ether=11,0x300,eth1"

Which worked ok, on 2.4.10 this isn't picked up. So I added
append="ether=15,0xb000,eth0 ether=11,0x300,eth1"

Now it works again, not exactly a bug but I guess it's worth mentioning.

Tommy

