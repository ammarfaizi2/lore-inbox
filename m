Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280667AbRKYCwg>; Sat, 24 Nov 2001 21:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKYCwZ>; Sat, 24 Nov 2001 21:52:25 -0500
Received: from mailrelay.netcologne.de ([194.8.194.96]:33720 "EHLO
	mailrelay.netcologne.de") by vger.kernel.org with ESMTP
	id <S280663AbRKYCwO>; Sat, 24 Nov 2001 21:52:14 -0500
Message-ID: <00aa01c1755c$2a5159a0$25aefea9@ecce>
From: "[MOc]cda*mirabilos" <mirabilos@netcologne.de>
To: <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <E167ja2-0004fF-00@carbon.btinternet.com> <9tpiio$n4u$1@cesium.transmeta.com>
Subject: Re: Network hardware: "Network Media Detection"
Date: Sun, 25 Nov 2001 02:52:04 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That is, it detects the presence of a (10BaseT) cable in the back of
the
> > card.. and then does appropriate stuff (ifup/down, dhcpcd) when the
event
> > happens.
> This is basically taking the interface down when the link disappears
> (and vice versa.)  Rather useful for portable systems.  Don't think
> anyone has implemented it, but it should be easy enough to do.

pcmcia-cs has (had?) this, just edit /etc/pcmcia/blah-script...
needed to do this to get the default route set on card load,
and removed on unload.

-mirabilos
--
Redistribution of this message body via AOL or the
Microsoft network strictly prohibited.
Quotation permitted if due credit is given.
(Excuse the X-Mailer, accusate my ISP for that)


