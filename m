Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154785-662>; Fri, 9 Oct 1998 10:08:41 -0400
Received: from snowcrash.cymru.net ([163.164.160.3]:1643 "EHLO snowcrash.cymru.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156289-662>; Fri, 9 Oct 1998 08:59:09 -0400
Message-Id: <m0zRiFI-0007U1C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: network nicety
To: rhw@bigfoot.com (Riley Williams)
Date: Fri, 9 Oct 1998 20:30:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.LNX.3.96.981009191551.26970I-100000@ps.cus.umist.ac.uk> from "Riley Williams" at Oct 9, 98 07:20:33 pm
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

>  2. Does Linux apply it automatically when the remote end is also a
>     Linux system? If not, there's little incentive for others to
>     also support it.

It isnt automatic. CBQ is a policy driven system. You get to set policy
according to local needs. Thats one of the problems you need to then
talk to the other end to pass policy (and also potentially along paths
packets are taking).

If you control both directions from a routing point then CBQ can
be a huge help as can other flow control schemes like RED (random
early drop - a simple scheme that punishes the highest bandwidth
users when congestion is occuring)

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
