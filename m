Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBOQ>; Thu, 25 Jan 2001 20:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAZBOG>; Thu, 25 Jan 2001 20:14:06 -0500
Received: from omega.cisco.com ([171.69.63.141]:35548 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S129169AbRAZBNz>;
	Thu, 25 Jan 2001 20:13:55 -0500
Message-Id: <4.3.2.7.2.20010126120516.029d0880@171.69.63.141>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 26 Jan 2001 12:12:30 +1100
To: "David S. Miller" <davem@redhat.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: hotmail not dealing with ECN
Cc: Juri Haberland <juri.haberland@innominate.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <14959.60545.51978.532381@pizda.ninka.net>
In-Reply-To: <3A6FD7A0.B45964A8@innominate.com>
 <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
 <3A6FD7A0.B45964A8@innominate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 01:06 AM 25/01/2001 -0800, David S. Miller wrote:
>Juri Haberland writes:
>  > Forget it. I mailed them and this is the answer:
>  >
>  > "As ECN is not a widely used internet standard, and as Cisco does not
>  > have a stable OS for their routers that accepts ECN, anyone attempting
>  > to access our site through a gateway or from a computer that uses ECN
>  > will be unable to do so."
>
>The interesting bit is the "Cisco does not have a stable OS..." part.

Cisco _routers_ don't care whether packets have ECN set or not.

>I've been told repeatedly by the Cisco folks that a stable supported
>patch is available from them for their firewall products which were
>rejecting ECN packets.

nothing has changed since before --
both the cisco PIX and cisco LocalDirector didn't used to function 
correctly with ECN bits set.

both were fixed less than a week after a bug was opened and both have 
updates available for download ...
that was many many months ago ..

i wonder if some folk are being too quick to point the finger at just one 
vendor.  did some versions of solaris have problems with ECN too?

>I'd really like Cisco to reaffirm this and furthermore, and
>furthermore get in contact with and correct the hotmail folks
>if necessary.

if Juri can forward me (privately) the details of the hotmail person that 
said the above, i'd be happy to ensure that it is resolved ..

>I have in fact noticed that some sites that did have the problem have
>installed the fix and are now accessible with ECN enabled.

good to hear.


cheers,

lincoln.
NB. some cisco routers may start adding the ability to set ECN to indicate 
congestion too  ...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
