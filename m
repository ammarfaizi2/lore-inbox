Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUBGB6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbUBGB6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:58:44 -0500
Received: from web10408.mail.yahoo.com ([216.136.130.110]:45206 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264507AbUBGB6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:58:42 -0500
Message-ID: <20040207015841.36287.qmail@web10408.mail.yahoo.com>
Date: Sat, 7 Feb 2004 12:58:41 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: Need help about scanner (2.6.2-mm1)
To: gene.heskett@verizon.net
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402061948.37410.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

Your help saved me lot of headache :-)

 --- Gene Heskett <gene.heskett@verizon.net> wrote: >
On Friday 06 February 2004 18:57, Steve Kieu
wrote:

> >-----BEGIN PGP SIGNED MESSAGE-----
> Take any device paths out of
> the /usr/local/etc/saned/nameofyourscanner.dll

just .conf ; not dll :-)

> leaving only a single [usb] as a specifier unless

Yes it saved me. It work now. Why no other sane
documentation said like yours? I think people at sane
project should take your point to add to their
documentation.

> Gerneally speaking, this doesn't work with rpms
> because the rpms don't
> install in the default path location.  So I build it
> all and
> recently, even with kernel 2.6.2, "it just works".

I dont use rpm based system, I use my own built linux
system half based on slackware 9.0 so your information
is really helpful. Before I got stuck. Run
sane-find-scanner, it said find usb scanner, but when
run scanimage -L it always tell me only bttv device
available!. Even I feed it with --device
libusb:XXX:XXX (from sane-find-scanner output) and it
still refuses, Invalid argument message. Hm until
now...

Thank you again.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJP1Kv07eUvBr8ysRAiFWAJ9k5T0vxNfEsq99mFl7JHmvwmDzLwCePzaJ
ONIrWzaEcvxtX//TaKXFx0M=
=sNHr
-----END PGP SIGNATURE-----


=====
S.KIEU

http://greetings.yahoo.com.au - Yahoo! Greetings
Send your love online with Yahoo! Greetings - FREE!
