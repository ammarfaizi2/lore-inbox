Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLGVpn>; Thu, 7 Dec 2000 16:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGVpd>; Thu, 7 Dec 2000 16:45:33 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:62729 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S129345AbQLGVpW>; Thu, 7 Dec 2000 16:45:22 -0500
Message-ID: <3A2FFEEC.3836165B@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <Pine.GSO.4.10.10012071337530.7874-100000@athena.ics.forth.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 7 Dec 2000 16:14:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You might want to try the Linux Trace Toolkit. It'll give you microsecond
accuracy on program execution time measurement.

Check it out:
http://www.opersys.com/LTT

Karim

Kotsovinos Vangelis wrote:
> 
> Is there any way to measure (with microsecond accuracy) the time of a
> program execution (without using Machine Specific Registers) ?
> I've already tried getrusage(), times() and clock() but they all have
> 10 millisecond accuracy, even though they claim to have microsecond
> acuracy.
> The only thing that seems to work is to use one of the tools that measure
> performanc through accessing the machine specific registers. They give you
> the ability to measure the clock cycles used, but their accuracy is also
> very low from what I have seen up to now.
> 
> Thank you very much in advance
> 
> --) Vangelis
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
