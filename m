Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbTCGVAT>; Fri, 7 Mar 2003 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbTCGVAS>; Fri, 7 Mar 2003 16:00:18 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:5083 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S261773AbTCGVAR>;
	Fri, 7 Mar 2003 16:00:17 -0500
Date: Fri, 7 Mar 2003 22:10:16 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/6)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <17913565781.20030307221016@tnonline.net>
To: "Jon Burgess" <Jon_Burgess@eur.3com.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entire LAN goes boo with 2.5.64
In-Reply-To: <80256CE2.006CEFC2.00@notesmta.eur.3com.com>
References: <80256CE2.006CEFC2.00@notesmta.eur.3com.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Some things you might want to look at:
>    Is the Linux box sending any traffic (look at the stats in ifconfig)?
>    Does a packet sniffer like http://www.ethereal.com/ give any clues as to the
> type of traffic on the network?
>    Does the same thing occur if you run less processes, e.g. boot into run level
> 1 or 3?
>    Are there any processes consuming an unreasonable amount of CPU time on the
> Linux box?
>    Is there a process which is being restarted many times a second, so top or ps
> shows a radiply increasing PID?

nope, nothing like that. Running just a bare minimum...

> It could be some network-aware process which has got stuck in a tight loop
> sending requests to your windows box, e.g. a DHCP client.
> I mention the DHCP client specifically because they sometimes get upset if you
> don't enable some specific kernel networking options like CONFIG_PACKET or
> CONFIG_FILTER & WinRoute might be acting as the DHCP server.

Yes,  you might be right. WinRoute is running as DCHP for the network,
and  the  problems  do  start as soon as Linux tries to lease an IP...
hm..

>      Jon


   



--------
PGP public key: https://tnonline.net/secure/pgp_key.txt

