Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277870AbRJIRlR>; Tue, 9 Oct 2001 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277869AbRJIRlH>; Tue, 9 Oct 2001 13:41:07 -0400
Received: from [160.131.145.131] ([160.131.145.131]:34052 "EHLO W20303512")
	by vger.kernel.org with ESMTP id <S277864AbRJIRks>;
	Tue, 9 Oct 2001 13:40:48 -0400
Message-ID: <006401c150e9$90198c40$839183a0@W20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Trever L. Adams" <trever_adams@yahoo.com>
In-Reply-To: <1002646705.2177.9.camel@aurora>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
Date: Tue, 9 Oct 2001 13:40:59 -0400
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

----- Original Message -----
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>


> I am seeing messages such as:
>
> Oct  9 12:52:51 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
> SRC=64.152.2.36 DST=MY_IP_ADDRESS LEN=52 TOS=0x00 PREC=0x00 TTL=246
> ID=1093 DF PROTO=TCP SPT=80 DPT=33157 WINDOW=34752 RES=0x00 ACK FIN
> URGP=0
>
> In my firewall logs.  I see them for ACK RST as well.  These are valid
> connections.  My rules follow for the most part (a few allowed
> connections to the machine in question have been removed from the
> list).  This often leaves open connections in a half closed state on
> machines behind this firewall.  It also some times kills totally open
> connections and I see packets rejected that should be allowed through.

This is someone on the outside scanning you for Back Orifice. I don't
understand why this is supposed to be a valid connection.
>From your iptables output, it looks like your rules are working properly.
(They aren't set up exactly how I would have done it, but it's all a matter
of style.)
Can you give a more specific example of something that it being DROPped when
it shouldn't be?

--Wilson.


