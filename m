Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRAQNeh>; Wed, 17 Jan 2001 08:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbRAQNe0>; Wed, 17 Jan 2001 08:34:26 -0500
Received: from mail.coiinc.com ([207.40.103.90]:1287 "EHLO mail.coiinc.com")
	by vger.kernel.org with ESMTP id <S131434AbRAQNeK>;
	Wed, 17 Jan 2001 08:34:10 -0500
Date: Wed, 17 Jan 2001 07:36:05 -0600 (CST)
From: Jerry Frana <franaj@mail.coiinc.com>
To: snpe <snpe@infosky.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with networking in 2.4.0
In-Reply-To: <01011714061700.00939@spnew>
Message-ID: <Pine.LNX.4.10.10101170733210.10241-100000@mail.coiinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

have you tried

echo 0  > /proc/sys/net/ipv4/tcp_ecn ?
for some reason PIX firewalls act strangely when explicit congestion
notification is used...

hope this helps..

david F.




On Wed, 17 Jan 2001, snpe wrote:

> Hello,
> 
> I have got 2 Linux machine with kernel 2.4.0 i kernel 2.2.18.
> I am in Belgrade , Yugoslavia and I can't access to any hosts :
> 
> for example, www.linux.co.yu (Island), www.skyrr.is, www.hotmail.com etc
> 
> Access is ok with kernel 2.2 even in a case when machine with 2.4 kernel is
> masquerading host.
> It doesn't work with any port.
> Ping works.
> 
> I think that these hosts are behind CISCO PIX firewall.
> 
> I am not sure if it is related with seting kernel.
> 
> Regards
> Haris Peco
> snpe@infosky.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
