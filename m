Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSFJMaq>; Mon, 10 Jun 2002 08:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFJMap>; Mon, 10 Jun 2002 08:30:45 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:129 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S313070AbSFJMam>;
	Mon, 10 Jun 2002 08:30:42 -0400
Date: Mon, 10 Jun 2002 08:24:44 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: <ltd@cisco.com>, <greearb@candelatech.com>, <mark@mark.mielke.cc>,
        <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <20020610.051857.97850707.davem@redhat.com>
Message-ID: <Pine.GSO.4.30.0206100821310.20296-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jun 2002, David S. Miller wrote:

>    From: Lincoln Dale <ltd@cisco.com>
>    Date: Mon, 10 Jun 2002 22:03:25 +1000
>
>    would you be willing to accept a patch that enables per-socket
>    accounting with a CONFIG_ option?
>
> What is the point?
>
> If all the dists will enable it then everybody eats the overhead.
> If the dists don't enable it, how useful is it and what's so wrong
> with it being an external patch people just apply when they need to
> diagnose something like this?
>

I think i would agree with Dave for it to be an external patch. You
really only need this during debugging. I had a similar patch when
debugging NAPI about a year ago. I didnt find it that useful after
a while because i could deduce the losses from SNMP/netstat output.

cheers,
jamal


