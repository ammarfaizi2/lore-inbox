Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132779AbRA0XPO>; Sat, 27 Jan 2001 18:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132790AbRA0XPE>; Sat, 27 Jan 2001 18:15:04 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:36114 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S132779AbRA0XOz>; Sat, 27 Jan 2001 18:14:55 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: routing between different subnets on same if.
Date: Sat, 27 Jan 2001 23:15:45 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <94vkr1$p4k$1@ncc1701.cistron.net>
In-Reply-To: <94v7nc$28g$1@ncc1701.cistron.net> <Pine.LNX.4.31.0101272202060.2119-100000@fogarty.jakma.org>
X-Trace: ncc1701.cistron.net 980637345 25748 195.64.65.67 (27 Jan 2001 23:15:45 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0101272202060.2119-100000@fogarty.jakma.org>,
Paul Jakma  <paul@clubi.ie> wrote:
>On Sat, 27 Jan 2001, Miquel van Smoorenburg wrote:
>
>> Did you enable forwarding with echo 1 > /proc/sys/net/ipv4/ip_forward ?
>>
>
>yes. the machine already routes correctly between the 2 subnets and
>the internet which is on a seperate interface. i also disabled
>/proc/sys/net/ipv4/conf/all/send_redirects, to no avail.

What about /proc/sys/net/ipv4/conf/*/rp_filter ? Should be zero
for the 192.* interface(s), I think.

Mike.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
