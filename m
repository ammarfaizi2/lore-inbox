Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSEWLFm>; Thu, 23 May 2002 07:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSEWLFl>; Thu, 23 May 2002 07:05:41 -0400
Received: from [194.228.240.2] ([194.228.240.2]:55818 "EHLO chudak.century.cz")
	by vger.kernel.org with ESMTP id <S316434AbSEWLFk>;
	Thu, 23 May 2002 07:05:40 -0400
Message-ID: <3CECCCDC.8030709@century.cz>
Date: Thu, 23 May 2002 13:05:00 +0200
From: Petr Titera <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0+) Gecko/20020519
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ipfwadm problems
In-Reply-To: <003301c201c5$04af5620$3701a8c0@maranti.com> 	<017201c201ca$13054810$320e10ac@irvine.hnc.com> <1022139239.265.0.camel@ADMIN>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Schaefer wrote:

> 
> BTW: A collegue of mine has the problem, that a host has 4 NICs; 2 to
> the LAN and 2 to the internet. Packets coming from LAN NIC 1 shall be
> forwarded through WWW NIC 1 and Packets from LAN NIC 2 through WWW NIC
> 2. Is there any way to perform this on a 2.2.x kernel using ipchains?

It can be done with advanced routing (look at www.lartc.org). You can 
specify different routing tables for each interface.

> And even whorse; They need destination NAT in the reverse manner of the
> above.
> 

With ipchains it can be tricky with iptables it is a piece of cake :)

Petr Titera
P.Titera@century.cz


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



