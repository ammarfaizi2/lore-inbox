Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWHJI7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWHJI7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWHJI7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:59:09 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:4774 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751472AbWHJI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:59:08 -0400
Message-ID: <44DAF559.8010705@comcast.net>
Date: Thu, 10 Aug 2006 04:59:05 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does Linux do RTTM?
References: <44DACA22.6090701@comcast.net> <20060809.231244.35509467.davem@davemloft.net>
In-Reply-To: <20060809.231244.35509467.davem@davemloft.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



David Miller wrote:
> From: John Richard Moser <nigelenki@comcast.net>
> Date: Thu, 10 Aug 2006 01:54:42 -0400
> 
>> Sorry for the dumb questions but Google is being massively bad at "tell
>> me about an obscure feature of the Linux kernel that nobody cares about"
>> today :)
> 
> When I type "Linux RTT measurement" to google, the following
> very authoritative paper on Linux's TCP congestion control
> shows up on the very first page:
> 
> http://www.cs.helsinki.fi/research/iwtcp/papers/linuxtcp.pdf
> 

This says Linux does use the RTTM "Timestamp" option for TCP; it does
not however tell me HOW it uses it.

So does it stamp the current time in UTC in milliseconds in the field?
Does it stamp in the number of jiffies since boot?  Does it use a
pseudo-randomly generated per-connection initial virtual clock value
with a microsecond-per-tick skew-factor to hide information about the
internal state of the system to avoid attacks on the PRNG to guess TCP
ISNs or attack ASLR?

> You should try a little bit harder with google next time, and
> also ask your question on a more appropriate list such as
> netdev@vger.kernel.org which is where the networking developers
> are subscribed.
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRNr1WAs1xW0HCTEFAQLugw//T+h1DA5AjQIB0sRVGef63WTZPHbO0Nhy
/6SGTO2lFHPpAv/esNRB7g4622ScOS0pQM3kedgiqGjT1mEhUx3h0PTGWFILbRfx
zzC5aypUv0lRiXhA43KWkIyWSLCubL0Aa1Mthm+Kn+g9jruXto3IIiLQWC3kC5Qm
6S6zFc0EE2VdC8UcWVHE+aAQDIA++VJ+Yb/bLqjNmHi+uaz553S3PT78R5Wq0mtG
aOXfWPd7gE17Ejrj9aAzz2M6M+zvkp7qPoRtezwakClA/OKYTyuBbqyasX7l/P89
R152KZSNOfts4667jegeC/9khXJEmkyjKI8BeYFFb1+VyRE56QSxbQYr1BwD6/Zu
YUkTBnv0qcxEyyYXkK2MBc9BNl2hjsix0AlgnTsYxB+56G9c2bBMRx4LKyXtVTeQ
7LGeFNJvwx5f721W2l+euXeLDStzDHj54TUMEoszT7xDhjsfhJx9mQCQIjG0sbw7
TlPOMfy9x/Sh4P4IQMeqjjHbdOiOBeOSQWJjpg2KhqU98qr+EiKdU1IaJ3R33T9k
INxhmW8nQ1F0k0k2k/tOZ7flD8cy/1ZAqaGyqTyy2c15xT0FwRh9Sq71Cnc81xkg
nfUDZZk5EJBUNaNtF6EKQ2yIGbfiDxXuagHmTKFQCD8Q1EukZZ9MKmin7yyT/lUR
n/ojUoyzSG4=
=prc3
-----END PGP SIGNATURE-----
