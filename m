Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSECSZM>; Fri, 3 May 2002 14:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315096AbSECSZL>; Fri, 3 May 2002 14:25:11 -0400
Received: from pop.gmx.de ([213.165.64.20]:28695 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315091AbSECSZK>;
	Fri, 3 May 2002 14:25:10 -0400
Date: Fri, 3 May 2002 20:23:52 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sis900 ethernet driver/IP stack getting REALLY confused...
Message-Id: <20020503202352.04858a22.sebastian.droege@gmx.de>
In-Reply-To: <20020503183407.AA9FC644@merlin.webofficenow.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="omojvdJ0=.qmSvwU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--omojvdJ0=.qmSvwU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2002 08:12:20 -0400
Rob Landley <landley@trommello.org> wrote:

> The sis900 driver in 2.4.18 works fine until I unplug and plug back in the 
> cat5 cable.  Then suddenly, packets start disappearing for 10 to 15 seconds 
> and then suddenly getting delivered (way late) out of nowhere, which confuses 
> IP to no end and apparently makes "ping" think the packet is corrupted.
> 
> If I reboot the box (shutdown -r now), the problem seems to stops manifesting 
> until I twiddle with the ethernet link status again.  (The first time this 
> happened I thought it was a hardware problem, and it did go away when I 
> plugged in an rtl8139 card and started using that instead, but now it's 
> happened on another system and it really does look like some kind of a device 
> driver problem...)
> 
> Here's an example run of ping when the problem is manifesting.  Notice the 
> sequence numbers and delay timestamps.  (We've tried swapping in three 
> different switches from two different manufacturers in between, so that's not 
> the problem...)  I think ping's getting confused by receiving 15 second-old 
> packets...
> 
> Help?
Hi,
I have a very similar problem... when I ping the box with the sis900 ethernet adapter everything wents fine except ~3 % of the pings. This pings need 10 times longer to get back to me than the other (eg. 72 ms <-> 1004 ms)
There is no other network activity on the network
And sometimes I get corrupted echo replies when there is traffic over the sis900...

I hope this helps somehow...

Bye
--omojvdJ0=.qmSvwU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE80tW7e9FFpVVDScsRAi5lAKCrjMlt+Wbst+cA9H3tu7lHojQpywCgsMP2
N2WI9fyYpmaeY+Luy560lBk=
=JOcZ
-----END PGP SIGNATURE-----

--omojvdJ0=.qmSvwU--

