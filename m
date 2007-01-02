Return-Path: <linux-kernel-owner+w=401wt.eu-S932887AbXABLtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXABLtQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbXABLtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:49:16 -0500
Received: from poczta.o2.pl ([193.17.41.142]:56999 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932887AbXABLtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:49:14 -0500
Date: Tue, 2 Jan 2007 12:50:50 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 and up to  2.6.20-rc2 Ethernet problems x86_64
Message-ID: <20070102115050.GA3449@ff.dom.local>
References: <20061229063254.GA1628@ff.dom.local> <4595CD1B.2020102@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4595CD1B.2020102@blueyonder.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 02:21:15AM +0000, Sid Boyce wrote:
> Jarek Poplawski wrote:
> >On 28-12-2006 04:23, Sid Boyce wrote:
> >>
> >>I first saw the problem on the 64x2 box after upgrading to 2.6.19. The
> >>network appeared OK with ifconfig and route -n, but I had no network
> >>access. Pinging any other box, the box was responding, but no response
> >...
> >>barrabas:/usr/src/linux-2.6.20-rc1-git5 # ssh Boycie ifconfig
> >>Password:
> >>eth0      Link encap:Ethernet  HWaddr 00:0A:E4:4E:A1:42
> >>          inet addr:192.168.10.5  Bcast:255.255.255.255  
> >>          Mask:255.255.255.0
> >
> >This Bcast isn't probably what you need.
> >
> >Regards,
> >Jarek P.
> >
> >
> 
> Corrected on the one box where it was not correct, problem is still there.

There are many things to suspect yet:
- firewall,
- switch,
- routing,
- ifconfig,
- other misonfigured box,
- connecting
and so on.

I think you should try with some linux networking group
at first and if you really think it's driver then
netdev@vger.kernel.org (instead of linux-kernel@).

If you could send full ifconfig, route -n (or ip route
if you use additional tables) and tcpdump (all packets)
from both boxes while pinging each other and a few words
how it is connected (other cards, other active boxes in
the network?) maybe something more could be found.

Cheers,
Jarek P. 

PS: Sorry for late responding.
