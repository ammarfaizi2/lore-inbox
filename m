Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVI3P7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVI3P7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVI3P7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:59:10 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:28420 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1030350AbVI3P7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:59:09 -0400
Message-ID: <433D608B.4010302@tuxrocks.com>
Date: Fri, 30 Sep 2005 09:58:03 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru, zippel@linux-m68k.org,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>	 <1127956200.8195.260.camel@cog.beaverton.ibm.com> <1127976803.15115.281.camel@tglx.tec.linutronix.de>
In-Reply-To: <1127976803.15115.281.camel@tglx.tec.linutronix.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas Gleixner wrote:
> The KTIMER_REARM case is the broken spot. I fixed this already as it was
> oopsing here to, but somehow I messed up with quilt.
> 
> tglx

This does indeed fix the panic.  Thanks.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDPWCKaI0dwg4A47wRAmjAAJ0XarfSYFyqAvGKi+uHbXZLg4+fEwCgso39
5hdrQfgzwMDdT9zM+4GkwLk=
=UoVd
-----END PGP SIGNATURE-----
