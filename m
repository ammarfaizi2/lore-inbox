Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266808AbRHRTaE>; Sat, 18 Aug 2001 15:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRHRT3y>; Sat, 18 Aug 2001 15:29:54 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:40497 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S266808AbRHRT3m>; Sat, 18 Aug 2001 15:29:42 -0400
Message-ID: <3B7EC211.1010205@blue-labs.org>
Date: Sat, 18 Aug 2001 15:29:21 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: Ralf Baechle <ralf@uni-koblenz.de>, Justin Guyett <justin@soze.net>,
        Jim Roland <jroland@roland.net>, linux-kernel@vger.kernel.org
Subject: Re: Aliases
In-Reply-To: <Pine.LNX.4.33.0108180554500.18300-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try before you buy.



# ip a a 192.168.0.0/24 brd + dev eth0
# ip r a 192.168.0.1/32 via 208.179.59.1 dev eth0

# ip r g 192.168.0.1
192.168.0.1 via 208.179.59.1 dev eth0  src 208.179.59.2
    cache  mtu 1500 advmss 1460

# ip r g 192.168.0.2
192.168.0.2 dev eth0  src 192.168.0.0
    cache  mtu 1500 advmss 1460

David

David Lang wrote:

>the problem with adding an entire netblock to an interface is that you
>frequently have a gateway on that netblock that belongs to another
>machine so you want to add 253 out of 256 addresses to your machine.
>
>how do you do that easily?
>
>example gateway is 192.168.1.1 and you want the rest of the 192.168.1.x
>network aliased on the machine.
>


