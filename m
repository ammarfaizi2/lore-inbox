Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVHaJY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVHaJY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 05:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVHaJY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 05:24:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18127 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751054AbVHaJY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 05:24:27 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Mateusz Berezecki <mateuszb@gmail.com>
Subject: Re: Atheros and rt2x00 driver
Date: Wed, 31 Aug 2005 12:23:35 +0300
User-Agent: KMail/1.8.2
Cc: Florian Weimer <fw@deneb.enyo.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
References: <6278d22205081711115b404a9b@mail.gmail.com> <87ll2ibkuk.fsf@mid.deneb.enyo.de> <20050831081636.GA28280@oepkgtn.mshome.net>
In-Reply-To: <20050831081636.GA28280@oepkgtn.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508311223.35304.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 11:16, Mateusz Berezecki wrote:
> Florian Weimer <fw@deneb.enyo.de> wrote:
> -> The FTC issues are shared by many (most?) wireless drivers.  The
> -> copyright/trade secret issues might be worked around by basing the
> -> work on the OpenBSD version of that driver (and someone is actually
> -> working on that).
> 
>  the problem with openbsd version of the hal is that it is - sorry to
>  say that - fundamentally broken, at least it was last time I was
>  checking. It misses just too much functionality. Apart from that, the

What it can do? In particular, can it:
* send packets with arbitrary contents? In particular, packets
  shorter than 3-address 802.11 header? packets with WEP bit set?
  Does it allow to do WEP encoding by host instead of hal?
  Any weird limitations?
* receive packets?
* tune to the given channel (or freq)?

If it can do that, everything else IIRC can be done in software.
Really, what prevents us from, say, beacons every 1/10s?

>  work I'm doing is partially based on that openbsd stuff :)
>  (no, this doesn't contradict what I wrote above)

Nice to see you are in "release early" crowd.

http://mateusz.agrest.org/atheros/:
may I suggest using atheros-20050805 instead of atheros-08052005
(will maintain correct sorting order in 2006,2007...)
--
vda
