Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288274AbSAHUQP>; Tue, 8 Jan 2002 15:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287798AbSAHUQG>; Tue, 8 Jan 2002 15:16:06 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:22145 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S288274AbSAHUPs>; Tue, 8 Jan 2002 15:15:48 -0500
Message-ID: <037c01c19881$59aa2310$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Sourav" <jeebu19@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <005c01c19876$30b51060$03015b0a@bulee>
Subject: Re: DLink DFE 538 TX (TealTek 8139) too slow
Date: Tue, 8 Jan 2002 21:16:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Sourav" <jeebu19@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 08, 2002 7:56 PM
Subject: DLink DFE 538 TX (TealTek 8139) too slow


> Why is DLink DFE 538TX Realtek 8139 too slow over
> 10Mbps HUB ( ~1Mbps) and apparantly too many
> collisions on a 2 computer network??!!! It also
> shows Half Duplex autonegotiated!!

This can be because of another NIC being broken (or just crappy). Most
10Mbps HUBs cannot handle full duplex, and if you enable this anyway, you
get excessive collisions. Check that the other computer does not have full
duplex enabled.

To check if it's the HUB, you can always put a patch cable directly between
the two computers. This way you will get 100Mbps too, if both supports it.

A patch cable is wired in a different way than a standard cable, so be sure
to get the right kind.

 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

- ABIT BP6(RU) - 2xCeleron 400 - 128MB/PC100/C2 Acer
- Maxtor 10/5400/U33 HPT P/M - Seagate 6/5400/U33 HPT S/M
- 2xDE-530TX - 1xTulip - Linux 2.4.17+ide+preempt

