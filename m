Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318834AbSHAMUZ>; Thu, 1 Aug 2002 08:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSHAMUY>; Thu, 1 Aug 2002 08:20:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54510 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318834AbSHAMTm>; Thu, 1 Aug 2002 08:19:42 -0400
Subject: Re: 2.4.19-rc5 from 2.4.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bruce <bruce@toorak.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <v03110701b96eb942e5cb@[192.168.0.3]>
References: <v03110701b96eb942e5cb@[192.168.0.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 14:39:30 +0100
Message-Id: <1028209170.14871.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 11:21, Bruce wrote:
> I have a problem that has manifested itself since 2.4.19-rcx.
> 
> An ADSL driver (1483-2.4.16.o) for the DLINK dsl100d PCI ADSL modem
> operational under 2.4.18 has been broken since 2.4.19,
> specifically under rc3,rc4 and rc5. (Haven't tested rc2 or rc1)
> 
> It appears to get/interpret an incorrect hardware address from the card.
> 
> There is a constraint. The driver was originally compiled for ITEX/DLINK
> under 2.4.16 and I don't have access to the source.

You will need the source to deal with it. Binary only modules have to
match the exact kernel properties, so you effectively threw away all the
freedom you got from Linux by relying on it.


