Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136666AbRA2CRN>; Sun, 28 Jan 2001 21:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136999AbRA2CRD>; Sun, 28 Jan 2001 21:17:03 -0500
Received: from mail5.mia.bellsouth.net ([205.152.144.17]:34458 "EHLO
	mail5.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S136666AbRA2CQq>; Sun, 28 Jan 2001 21:16:46 -0500
Message-ID: <3A74D2BE.2020000@bellsouth.net>
Date: Sun, 28 Jan 2001 21:17:34 -0500
From: Louis Garcia <louisg00@bellsouth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-8 i686; en-US; m18) Gecko/20010127
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.1-pre11
In-Reply-To: <3A74B16D.6020304@bellsouth.net> <20010128203703.T19833@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:

> Em Sun, Jan 28, 2001 at 06:55:25PM -0500, Louis Garcia escreveu:
> 
>> I am getting messages everytime I use the network from my RH7 + 
>> kernel-2.4.1-pre11 system:
>> 
>> modprobe: modprobe: Can't locate module net-pf-10
>> 
>> I have checked my .config  and can't find that modules. This does not 
>> happen with 2.4.0 kernel, only with the latest pre series maybe pre7 on.
> 
> 
> you haven't included support for IPv6 and your distribution initscripts is
> trying to load it for some reason, two solutions:
> 
> 1. enable IPv6 in your kernel build
> 2. disable it in your /etc/modules.conf file, like this:
> 
> alias net-pf-10 off
> 
> - Arnaldo
> 
> 
> 
Anyone have an idea where in the initscripts does this happen?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
