Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276540AbRI2QcM>; Sat, 29 Sep 2001 12:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276543AbRI2QcD>; Sat, 29 Sep 2001 12:32:03 -0400
Received: from otter.mbay.net ([206.40.79.2]:3089 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S276540AbRI2Qbu>;
	Sat, 29 Sep 2001 12:31:50 -0400
Date: Sat, 29 Sep 2001 09:32:00 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Ingo Molnar <mingo@elte.hu>
cc: "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.20.0109290931160.18362-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Ingo Molnar wrote:

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

Would this scheme work for crash dump capturing?

john

