Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269091AbTCDC2R>; Mon, 3 Mar 2003 21:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269092AbTCDC2R>; Mon, 3 Mar 2003 21:28:17 -0500
Received: from mx02.cyberus.ca ([216.191.240.26]:5391 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id <S269091AbTCDC2P>;
	Mon, 3 Mar 2003 21:28:15 -0500
Date: Mon, 3 Mar 2003 21:38:17 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Terje Eggestad <terje.eggestad@scali.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, "" <netdev@oss.sgi.com>,
       "" <linux-net@vger.kernel.org>, "" <davem@redhat.com>
Subject: Re: anyone ever done multicast AF_UNIX sockets?
In-Reply-To: <1046734165.27924.263.camel@eggis1>
Message-ID: <20030303212628.M67734@shell.cyberus.ca>
References: <3E5E7081.6020704@nortelnetworks.com> <1046695876.7731.78.camel@pc-16.office
 .scali.no>  <3E638C51.2000904@nortelnetworks.com> <1046720360.28127.209.camel@eggis1>
  <3E63D73A.2000402@nortelnetworks.com> <1046734165.27924.263.camel@eggis1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Terje,

On Mon, 4 Mar 2003, Terje Eggestad wrote:

> How do you design a protocol that uses multicast to send a request to do
> work?
>
> All uses I can think of right now of multicast/broadcast is:
> * Discovery, like in NIS.
> * Announcements like in OSPF.
> * update like in NTP broadcast
>

I know we are digressing away from main discussion ...

The concept of reliable multicast is known to be useful.
Look at(for some sample apps):
http://www.ietf.org/html.charters/rmt-charter.html

But we are talking about a distributed system in that context.

Agreed, reliability and multicast do not always make sense.


cheers,
jamal
