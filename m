Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSGOKmm>; Mon, 15 Jul 2002 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSGOKml>; Mon, 15 Jul 2002 06:42:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53254 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317422AbSGOKml>; Mon, 15 Jul 2002 06:42:41 -0400
Date: Mon, 15 Jul 2002 06:39:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: dean-list-linux-kernel@arctic.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <20020714.224517.45499035.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1020715062707.23142A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, David S. Miller wrote:

>    From: Bill Davidsen <davidsen@tmr.com>
>    Date: Sun, 14 Jul 2002 21:39:12 -0400 (EDT)
> 
>    Clearly FAQ means frequently asked, not answered. I can't find the
>    appropriate patch, clearly some people regard allowing source routing to
>    be a benefit.
>     
> Source routing exists in every single 2.4.x kernel every released.
> What are you talking about?  There is no patch to speak of, it's
> already there.

Um, many people who are being probed from the Internet would like very
much to NOT have it there, certainly by default. And would like to send an
arp request and in return get a valid mac address.

I totally miss why anyone would consider this behaviouracceptable, much
less desirable. Perhaps you or someone could explain why either accepting
source routing or sending out invalid arp responses are desirable at all,
much less as default behaviour. One is a security hole, the other brings
the network group to the door with arpwatch output.

After some hours of reading the google results I see lots of questions, a
few dubious workarounds, and zero people claiming that it's a good thing
to work that way. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

