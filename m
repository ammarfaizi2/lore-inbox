Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbRG3TaE>; Mon, 30 Jul 2001 15:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbRG3T3p>; Mon, 30 Jul 2001 15:29:45 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:21468 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S267615AbRG3T3Y>;
	Mon, 30 Jul 2001 15:29:24 -0400
Date: Mon, 30 Jul 2001 15:26:46 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <diffserv-general@lists.sourceforge.net>
cc: <kuznet@ms2.inr.ac.ru>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
        <lartc@mailman.ds9a.nl>, <rusty@rustcorp.com.au>, <thiemo@sics.se>,
        Sridhar Samudrala <samudrala@us.ibm.com>,
        Renu Tewari <tewarir@us.ibm.com>
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
 Prioritized Accept Queue
In-Reply-To: <OF8753E938.DCEA2C85-ON85256A99.005DE1F6@pok.ibm.com>
Message-ID: <Pine.GSO.4.30.0107301515090.7013-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



For startes, can you fix
oss.software.ibm.com so it respects ECN?

In regards to policing SYNs i am not sure what additional
value you provide to the mechanisms currently available under
2.4 ingress traffic policing; the simplest example we provided
was on SYN policing albeit for DoS prevention.
Since i refuse to turn off ECN, i cant access your web page
You can use the skbmark to prioritize based on policies
installed on the ingress and drop early ...

Incase you are using this scheme already you should stick to the
ingress policer which uses a dual Token Bucket not what netfilter uses..

cheers,
jamal

On Mon, 30 Jul 2001, Douglas M Freimuth wrote:

>
>
> On Fri, 27 Jul 2001,Sridhar wrote:
>
> >The documentation on HOWTO use this patch and the test results which show
> an
> >improvement in connection rate for higher priority classes can be found at
> our
> >project website.
> >        http://oss.software.ibm.com/qos
>
>      For additional detail regarding the Prioritized Accept Queue (PAQ)
> patch please read
> "Kernel Mechanisms for Service Differentiation in Overloaded Web Servers"
> originally published in
> the 2001 Proceedings of the USENIX Annual Technical Conference
> (USENIX Association, 2001), pp. 189-202. at the following USENIX site:
>
> http://www.usenix.org/publications/library/proceedings/usenix01/voigt.html
>
> For USENIX  nonmembers later this week will "reprint" this USENIX paper on
> our project
> website.
>      http://oss.software.ibm.com/qos
>
> --Doug
> =================================================================
> Doug Freimuth
>    IBM TJ Watson Research Center
>    Office  914-784-6221
>    dmfreim@us.ibm.com
>
>
> _______________________________________________
> Diffserv-general mailing list
> Diffserv-general@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/diffserv-general
>

