Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSFKOaG>; Tue, 11 Jun 2002 10:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSFKOaE>; Tue, 11 Jun 2002 10:30:04 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:41148 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S317068AbSFKOaB>; Tue, 11 Jun 2002 10:30:01 -0400
Message-ID: <3D060948.9060104@antefacto.com>
Date: Tue, 11 Jun 2002 15:29:28 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: remedy@mirotel.net, linux-kernel@vger.kernel.org
Subject: Re: net sysctls questions
In-Reply-To: <02061117004401.01217@fortress.mirotel.net>	<3D06051C.3030305@antefacto.com> <20020611.071225.65985367.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Padraig Brady <padraig@antefacto.com>
>    Date: Tue, 11 Jun 2002 15:11:40 +0100
> 
>    /proc/sys/net/ipv4/conf/../{arp_filter,tag}
>    are not documented.
>    
> Nobody had time to document them, that is all.
> 
>    /proc/sys/net/ipv4/icmp_rate_limit is jiffies.
>    Shouldn't this be HZ, i.e. jiffies shouldn't
>    be exported to userspace as it's non portable?
> 
> What if you want to specify value smaller than HZ?
> That is the most typical for this setting.

Current default is 100 (allow 1 ICMP packet/s on Intel
or 10/s on alpha). I suppose milliseconds is the most
sensible unit to use?

Padraig.

