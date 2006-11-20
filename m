Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933930AbWKTGDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933930AbWKTGDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933950AbWKTGDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:03:53 -0500
Received: from raven.upol.cz ([158.194.120.4]:23771 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S933930AbWKTGDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:03:52 -0500
Date: Mon, 20 Nov 2006 06:10:16 +0000
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [e-mail problems] with infradead.org recipients
Message-ID: <20061120061016.GA490@flower.upol.cz>
References: <slrnem0qco.fp5.olecom@flower.upol.cz> <45609CA9.8030806@garzik.org> <1163962173.6925.70.camel@pmac.infradead.org> <20061120002630.GB16937@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120002630.GB16937@flower.upol.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:26:30AM +0000, olecom wrote:
> On 2006-11-19, David Woodhouse wrote:
> []
> > I don't see either of those connection attempts in the logs for
> > canuck.infradead.org. Canuck is on GMT-5, and I've looked in its logs
> > for a few minutes around 08:27 and around 06:49. Nothing seems to match
> > your sender address.
> 
> Yes. I've told about DNS and IP, but forgot to show logs.
> 
> On time of writing first message, there was no DNS answer from root
> servers about infradead; now i see ns0 on infradead.org request and ns0,
> ns1, ns2 servers on canuck.infradead.org, ping is working, i can connect
> to ports. Week or so ago there was "no route to host" problem. Because of
> sending via smarthost and blocked outgoing 25 port, this all i can say.

That message is delayed. "No route to host problem" is a permanent
problem. And it seems bad ISP: or IPv6, or IPv4 route fails on send. From
my point of view all is OK:

,-*- shell -*-
|olecom@deen:~$ host 209.217.80.40
|Name: canuck.infradead.org
|Address: 209.217.80.40
|
|olecom@deen:~$ ping 209.217.80.40
|PING 209.217.80.40 (209.217.80.40) 56(84) bytes of data.
|64 bytes from 209.217.80.40: icmp_seq=1 ttl=47 time=122 ms
|
|--- 209.217.80.40 ping statistics ---
|1 packets transmitted, 1 received, 0% packet loss, time 0ms
|rtt min/avg/max/mdev = 122.266/122.266/122.266/0.000 ms
|olecom@deen:~$ nc 209.217.80.40 22
|SSH-2.0-OpenSSH_4.2
|
|olecom@deen:~$ ping6 canuck.infradead.org
|connect: Network is unreachable
|olecom@deen:~$
`-*-

   ----- The following addresses had transient non-fatal errors -----
   <dwmw2@infradead.org>
   
     --- The transcript of the session follows ---
     <dwmw2@infradead.org>... Deferred: A route to the remote host is
not available.
Warning: message still undelivered after 4 hours
Will keep trying until message is 5 days old

[-- Attachment #2 --]
[-- Type: message/delivery-status, Encoding: 7bit, Size: 0.3K --]

Reporting-MTA: dns; raven.upol.cz
Arrival-Date: Mon, 20 Nov 2006 01:27:45 +0100

Final-Recipient: RFC822; dwmw2@infradead.org
Action: delayed
Status: 4.4.1
Remote-MTA: DNS; canuck.infradead.org
Last-Attempt-Date: Mon, 20 Nov 2006 05:33:20 +0100
Will-Retry-Until: Sat, 25 Nov 2006 01:27:45 +0100

[-- Attachment #3 --]
[-- Type: message/rfc822, Encoding: 7bit, Size: 1.8K --]

To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [e-mail problems] with infradead.org recipients
From: Oleg Verych <olecom@flower.upol.cz>
