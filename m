Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRI3Dij>; Sat, 29 Sep 2001 23:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272540AbRI3Dia>; Sat, 29 Sep 2001 23:38:30 -0400
Received: from mailg.telia.com ([194.22.194.26]:12769 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S272449AbRI3DiT>;
	Sat, 29 Sep 2001 23:38:19 -0400
Message-ID: <3BB693AC.6E2DB9F4@canit.se>
Date: Sun, 30 Sep 2001 05:38:20 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> sorry :-) definitions of netconsole-terms:
>
> 'server': the host that is the source of the messages. Ie. the box that
>           runs the netconsole.o module. It serves log messages to the
>           client.
>
> 'client': the host that receives the messages. This box is running the
>           netconsole-client.c program.
>
> 'target': the host that gets the messages sent - ie. the client.
>
> 'target IP address': the IP address of the 'target'.
>
> 'target ethernet address': the local-net host or first-hop router that
>                            gets the netconsole UDP packets sent. Ie. it
>                            does not necesserily match the MAC address of
>                            the 'target'.
>
> (i can see where the confusion comes from, 'syslog servers' are ones that
> receieve syslogs. It's a backwards term i think. 'netconsole servers' are
> the ones that produce the messages.)
>

Servers is usually the thing waiting for something to be sent to it, the
client is the sending part(initiator). this works for web servers , X
servers, log servers but strangley not for netconsole where everything is
backwards.

>
> does it make more sense now? :)
>

Not really :)


