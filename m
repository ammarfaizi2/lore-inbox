Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSH0KUN>; Tue, 27 Aug 2002 06:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSH0KUN>; Tue, 27 Aug 2002 06:20:13 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:46255 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S315458AbSH0KUM>;
	Tue, 27 Aug 2002 06:20:12 -0400
Date: Tue, 27 Aug 2002 06:17:42 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Mala Anand <manand@us.ibm.com>
cc: <davem@redhat.com>, <netdev@oss.sgi.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Bill Hartner <bhartner@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
In-Reply-To: <OFFFA46B92.252E5659-ON87256C21.000BB73B@boulder.ibm.com>
Message-ID: <Pine.GSO.4.30.0208270605480.6895-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Aug 2002, Mala Anand wrote:

> Troy Wilson (who works with me) posted SPECweb99 results using my
> skbinit patch to lkml on Friday:
>  http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.2/1470.html
> I know you don't subscribe to lkml. Have you seen these results?
> On Numa machine it showed around 3% improvement using SPECweb99.
>

The posting you pointed to says 1% - not that it matters. It becomes more
insignificant when skb recycling comes in play mostly because the alloc
and freeing of skbs doesnt really show up as hotlist item within
the profile.
I am not saying it is totaly useless -- anything that will save a few
cycles is good;

cheers,
jamal

