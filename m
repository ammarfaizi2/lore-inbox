Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKFNDG>; Mon, 6 Nov 2000 08:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbQKFNC4>; Mon, 6 Nov 2000 08:02:56 -0500
Received: from mail.cyberus.ca ([209.195.95.1]:9633 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S129034AbQKFNCr>;
	Mon, 6 Nov 2000 08:02:47 -0500
Date: Mon, 6 Nov 2000 08:02:44 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Oliver Xymoron <oxymoron@waste.org>, barryn@pobox.com,
        Werner.Almesberger@epfl.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <20001106121153.A14104@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.4.20.0011060758480.3358-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 6 Nov 2000, Andi Kleen wrote:

> On Mon, Nov 06, 2000 at 11:02:47AM +0000, Alan Cox wrote:
> > >        with the TCP ECN_ECHO and CWR flags set, to indicate
> > >        ECN-capability, then the sender should send its second
> > >        SYN packet without these flags set. This is because
> > 
> > Now that is nice. The end user perceived effect is that folks with faulty 
> > firewalls have horrible slow web sites with a 3 or 4 second wait for each
> > page. The perfect incentive. If only someone could do the same to path mtu
> > discovery incompetents.
> 
> And it penalizes good guys.
> If the host cannot answer to the first SYN for some legitimate reason 
> then it'll never be able to use ECN. 
> 

The problem with ECN, unlike path MTU discovery, is not stupid
administrators who set the wrong things in the firewall; rather it is
stupid firewal/content-switch/intrusion-detector implementations.       
With Sally's and KK's clout and enough noise from users vendors will fix
this.
CISCO has already done it. Raptor is next. Nortel products do/will not  
have this problem. 

There is no reason to make the deployment more complex than it is and i am
not sure how wise it is to make the Mark Handley extension part of the
RFC. Not just because of complexity, but also because of holes such as the
one Andi points out.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
