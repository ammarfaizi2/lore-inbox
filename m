Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSK3W0C>; Sat, 30 Nov 2002 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSK3W0C>; Sat, 30 Nov 2002 17:26:02 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:61098 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261218AbSK3W0B>; Sat, 30 Nov 2002 17:26:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Florian Schmitt <florian@galois.de>
To: Sipos Ferenc <sferi@mail.tvnet.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module loading 2.5.50 + nvidia patch
Date: Sun, 1 Dec 2002 08:02:20 +0100
User-Agent: KMail/1.4.2
References: <1038665822.1045.3.camel@zeus.city.tvnet.hu>
In-Reply-To: <1038665822.1045.3.camel@zeus.city.tvnet.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212010802.36935.florian@galois.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> With
> insmod, I can load modules, but I'd like that the kernel do it
> automatically such as in 2.4. In kernel config, the neccessary options
> for this are set. What am I missing, or how has the kernel configuration
> changed? 

I ran into the same problem yesterday. If I remember correctly (I don't have 
access to that computer right now), Rusty's new modutils look for 
/etc/modutils.conf instead of /etc/modules.conf... A softlink to modules.conf 
fixed that for me.

Regards,
  Flo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE96bP8H7Gei80C0lQRAsawAJ42wkDOzXZrR/5GqP9sIsVBywQfEgCgk7HD
f/uLnc0Mgu5btsFEtYY2xWg=
=JgW1
-----END PGP SIGNATURE-----

