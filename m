Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRHRT0Y>; Sat, 18 Aug 2001 15:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbRHRT0O>; Sat, 18 Aug 2001 15:26:14 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:47925 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S266606AbRHRT0A>; Sat, 18 Aug 2001 15:26:00 -0400
Message-ID: <3B7EC12B.4010204@blue-labs.org>
Date: Sat, 18 Aug 2001 15:25:31 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: Justin Guyett <justin@soze.net>, Jim Roland <jroland@roland.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Aliases
In-Reply-To: <00df01c127a8$c354ad20$bb1cfa18@JimWS> <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net> <20010818143232.A11687@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>For various reasons interfaces aliases are deprecated.  The recommended
>way of doing things these days is just adding more addresses to an
>interface with the ip(8) program from the iproute package.  It works like:
>
>  ip addr add 192.168.2.0/24 broadcast 192.168.2.255 scope host dev eth0
>

You can shorten this to:

    ip a a 192.168.2.0/24 brd + dev eth0

..and leaving the scope global [by default] which makes it fully reachable.

David


