Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSLPW00>; Mon, 16 Dec 2002 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSLPW0Z>; Mon, 16 Dec 2002 17:26:25 -0500
Received: from 217-127-206-122.uc.nombres.ttd.es ([217.127.206.122]:54468 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP
	id <S261799AbSLPW0X>; Mon, 16 Dec 2002 17:26:23 -0500
Message-ID: <016c01c2a553$83f1b680$152ea8c0@maincomp>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
       <linux-kernel@vger.kernel.org>
References: <61DB42B180EAB34E9D28346C11535A78011303BD@nocmail101.ma.tmpw.net>
Subject: Re: NAT helper module for MSN
Date: Mon, 16 Dec 2002 23:36:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not masquerading, only NAT.
Everything works except outgoing file transmission, apparently caused by the
internal network IPs going out inside the packet (not the headers). So
unless the packets are modified on the fly, I don't think there's a chance
it can work :-) (unless of course they were originated with the public IP,
but trillian doesn't have the feature to edit that, and even if it did, it
doesn't solve the problem in the right place).

----- Original Message -----
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Carlos Fernandez Sanz'" <cfs-lk@nisupu.com>;
<linux-kernel@vger.kernel.org>
Sent: Monday, December 16, 2002 23:24
Subject: RE: NAT helper module for MSN


> >
> > Is there a help module to help MSN work through a NAT'ed connection?
> >
> > If there isn't one, is there an ongoing project to write one
> > I can join?
> >
>
> This may not be strictly kernel related, are you using masquerading?  I
have
> yet to have a prob with MSN messenger using 2.2 with ipmasq.  But, have
you
> checked http://ipmasq.cjb.net/
>
> Here's the masq modules I have loaded.
> ip_masq_quake           1420   0  (unused)
> ip_gre                  6776   0  (unused)
> ip_masq_autofw          2556   0  (unused)
> ip_masq_portfw          2636   2
> ip_masq_mfw             3272   0
> ip_masq_ipsec          11812   0  (unused)
> ip_masq_pptp            6856   0
> ip_masq_irc             1656   0  (unused)
> ip_masq_raudio          3064   0
> ip_masq_ftp             2680   0
>
> Maybe you should check withe the iptables group at the netfilter home:
> http://www.netfilter.org/
>
> Hope that helps.
> Bruce H.
>

