Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132173AbQLHXSU>; Fri, 8 Dec 2000 18:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbQLHXSK>; Fri, 8 Dec 2000 18:18:10 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:54794 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S132173AbQLHXSD>; Fri, 8 Dec 2000 18:18:03 -0500
Message-ID: <3A3164FB.EA5957B7@cc.gatech.edu>
Date: Fri, 08 Dec 2000 17:47:23 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
Organization: CoC, GaTech
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
CC: Ion Badulescu <ionut@cs.columbia.edu>,
        Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0012081254360.26353-100000@age.cs.columbia.edu> <3A3162A0.825FA107@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * put cable in *
>
> eth0: card reports no RX buffers.
> eth0: card reports no resources.
> eth0: card reports no RX buffers.
> eth0: card reports no resources.

you know, this might be entirely unrelated, but i had the exact same type of
problem with a brand new machine running a not-so-brand new EE100 nic.   i
couldn't figure out what was wrong, since it was a literal replacement with an
earlier machine with the same general setup (except it was a pentium-90, this
was a celeron-500-something) ... and in the p-90, that network card never gave
a hiccup.

the only way i could get it to stop was to change the network infrastructure.
this card was connected to a cisco catalyst 1000 24-port 10T switch and 2-port
100T switch.  i stuck a generic repeater off one of the 100T ports, jacked the
ee100 into the repeater, and the problem *went away*.

i thought it was just an anomaly.

if it will help, i can get the info from that machine and post it to this
thread.

cheers,

josh fryman


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
