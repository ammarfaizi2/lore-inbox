Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbUB1DKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 22:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbUB1DKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 22:10:53 -0500
Received: from a213-22-119-56.netcabo.pt ([213.22.119.56]:45447 "HELO
	rootisg0d.org") by vger.kernel.org with SMTP id S263115AbUB1DKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 22:10:51 -0500
Message-ID: <001901c3fda8$84cbaee0$0c00a8c0@darkgod>
From: "psycosonic" <psycosonic@rootisg0d.org>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: kernel 2.4.25 and SIS900 ethernet card
Date: Sat, 28 Feb 2004 03:11:11 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2055
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hey.

I'm having some problems since i updated from kernel 2.4.24 to 2.4.25 .. it 
seems that 2.4.25 has some incompatibility with SIS900 ethernet card. Well 
it should work @ 100Mbit .. and it only works @ 10Mbit... i've used mii-tool 
to diagnose the problem.. what i got was this:

root@XXX:~# mii-tool
eth0: negotiated 100baseTx-FD, link ok
eth1: negotiated 100baseTx-FD, link ok <--- this is the one i'm talkin' 
about ( SIS900 )


...
00:0e.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 02)
...


--------

Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , with 
2.4.25 it only goes to 2,2Mb/s :(

What should i do ? i've already tried to compile the driver from SIS but 
it's the same.

I'll be waiting for an answer.
Thanks.

Hope this is useful :)

Cya m8's * *


