Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRI3TpV>; Sun, 30 Sep 2001 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274061AbRI3TpM>; Sun, 30 Sep 2001 15:45:12 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:61458 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274055AbRI3To5>; Sun, 30 Sep 2001 15:44:57 -0400
Message-ID: <3BB77591.C1349C09@osdlab.org>
Date: Sun, 30 Sep 2001 12:42:09 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
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
> does it make more sense now? :)

Thanks for the definitions.  I can work with them,
although I think that there's much room for improvement...

~Randy
