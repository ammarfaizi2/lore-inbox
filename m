Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVGZBq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVGZBq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGZBq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:46:59 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:30063 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261482AbVGZBq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:46:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=O2kRE/Pi6jmvlcVRuvDroC8hylv0RBuxApd/et07njqKRicQgw68ncK4TxFfUUv2wUYU+bNKH7Zh6mpeIomRIfnT7mfv6RcW9Gtuke2V8bsd4wz582kqqizwDkb+Nix4L9Vi4OpbiYC74Sno3W8msY90Cs33TguZPCK/Q6VqYkY=  ;
Message-ID: <42E59E0E.5030306@yahoo.com.br>
Date: Mon, 25 Jul 2005 23:21:02 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Haninger <ahaning@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com> <105c793f05072507426fb6d4c9@mail.gmail.com>
In-Reply-To: <105c793f05072507426fb6d4c9@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Haninger wrote:
> On 7/22/05, Francisco Figueiredo Jr. <fxjrlists@yahoo.com.br> wrote:
> 
>>Hangs appears just before mounting filesystems message and before configuring
>>system to use udev.
> 
> I don't know if this will help, but there were issues raised earlier
> about older versions of udev causing hangs on newer kernels. Look for
> the thread with the subject "2.6.12 udev hangs at boot". Actually,
> look here: http://marc.theaimsgroup.com/?l=linux-kernel&m=111909806104523&w=2
> 
> Basically, upgrade to a newer udev if you're running an older one (I
> think I had 0.30 at the time; installing 0.58 sped things up
> noticeably).
> 


Hi Andrew!

Thanks!

Indeed udev update solved my problem with "preparing system to use udev"
hang. It now works like a charm. I had 030 version too.

Only the "mounting filesystem" hangs persists :(

May it have something about I have reiserfs 3.6 as my main filesystem?

I think it may be some type of configuration or update too.


Thank you very much.

- --
Regards,

Francisco Figueiredo Jr.
Npgsql Lead Developer
http://gborg.postgresql.org/project/npgsql
MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org


- -------------
"Science without religion is lame;
religion without science is blind."

                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQuWeDv7iFmsNzeXfAQJvCQf/Va27h0f9bD1l6c2pL8yaxL6McQABqhcw
wy+Yh1pt1arltYfAuvvXkF9kHfYO9jkmDztm40r0nCI4EJ1Plr+mcSFm0MYOKEfP
o1dCV3lsGHiLla7ObxO4DWjO7FqAanOj5VW2dWp8MBgatimDopPxrfdb3ciFyP/h
HQBJ3rodotm8CnchqFS7sPERaxpG9Q32JyRrsUq4QNh+jcOLsIKjuq32qtQeO10B
qpMqJ4S2fm5q+rdz5Z5iBIDgRZ0NHcXnwwQcYDkNRpNWN+K4Zk8/hXywd8uJ++lb
stKOlKoafqWlDYRU3SylSdhY+gsnDfFpIV97o/+/1ekd1x4PlzkOUg==
=2AMa
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
