Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSBSA7Y>; Mon, 18 Feb 2002 19:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289138AbSBSA7R>; Mon, 18 Feb 2002 19:59:17 -0500
Received: from ns.snowman.net ([63.80.4.34]:15624 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S289096AbSBSA7C>;
	Mon, 18 Feb 2002 19:59:02 -0500
Date: Mon, 18 Feb 2002 19:58:13 -0500
From: Stephen Frost <sfrost@snowman.net>
To: bert hubert <ahu@ds9a.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Message-ID: <20020218195813.O20319@ns>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3C717DEA.7090309@candelatech.com> <E16cwUx-00073d-00@the-village.bc.nu> <20020219002614.A27210@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P3sknYnWZi2jLDOU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219002614.A27210@outpost.ds9a.nl>; from ahu@ds9a.nl on Tue, Feb 19, 2002 at 12:26:14AM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 7:55pm  up 103 days, 22:06, 12 users,  load average: 1.01, 1.04, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--P3sknYnWZi2jLDOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* bert hubert (ahu@ds9a.nl) wrote:
> $ uname -a ; uptime
> Linux newyork-1 2.2.18 #3 Mon Dec 11 15:57:33 EST 2000 i686 unknown
>   6:22pm  up 425 days,  1:35,  3 users,  load average: 0.10, 0.05, 0.01

Linux ns2 2.2.16 #1 Sun Jul 30 21:57:38 EDT 2000 i386 unknown
 19:55:29 up 1 day, 15:06,  1 user,  load average: 0.00, 0.03, 0.00

-rw-r--r--    1 root     root         1569 Oct  8  2000 /var/log/dmesg

No problems here so far, just wrapped.  Processes seemed to all handle
it okay though ps now shows some things started in 2003.. :)

> This server is pretty remote and hard to reach, and not sure to reboot
> properly unattended - are there predictions about how well 2.2.18 will
> survive jiffy wraparound?

It's honestly not good to not know how to reboot a box unattended. :)

> Would you consider it worth rebooting for? By the way, this is our second
> most important production server, I'm exceedingly pleased with the
> stability. We've abused it no end.

I'd certainly make arrangements to have it rebooted if necessary.  If
rebooting is a huge problem then I'd say just have someone on hand in
case you *have* to.

	Stephen

--P3sknYnWZi2jLDOU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8caMlrzgMPqB3kigRAraYAJ0bGmr82ZMqHDTkF3591jpQaP4O6ACfct8p
xDKpL92D0/bp5108s6U6vYw=
=0Ufc
-----END PGP SIGNATURE-----

--P3sknYnWZi2jLDOU--
