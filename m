Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSLBOpL>; Mon, 2 Dec 2002 09:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSLBOpL>; Mon, 2 Dec 2002 09:45:11 -0500
Received: from 182-121-ADSL.red.retevision.es ([80.224.121.182]:36035 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S264730AbSLBOpJ>; Mon, 2 Dec 2002 09:45:09 -0500
Date: Mon, 2 Dec 2002 15:52:36 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap15a incremental diff against 2.4.20-ac1
Message-ID: <20021202145236.GG2479@jerry.marcet.dyndns.org>
References: <20021202032448.GA26608@jerry.marcet.dyndns.org> <Pine.LNX.4.44L.0212021048520.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0212021048520.15981-100000@imladris.surriel.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.20-jam0-marcet i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rik van Riel <riel@conectiva.com.br> [021202 13:52]:

>>There was no inconsistency but in three spots.

>Your changes look good. Maybe the lookup_swapcache() thing would
>be more beautiful, but it's equivalent to the code you've got in
>place. Your patch should just work.

There are a couple issues, e.g. in mm/filemap.c, in the patchset I sent.
I'll be looking into it today. I hope to send something within a few
hours. But since tomorrow morning I'm moving, and I'm now packaging et
all, I might have no time to finish it today. In that case until
Wednesday I don't think I'll be able to continue on it...

>>Feel free to try it. I'm running it right now and so far no problems.
>>The vm usage has definitely improved, but there are still slight stalls
>>when there's a high disk io. Say, in periods of ~2-3s the system stopped
>>responding for a few cents of a sec, as if it had tachycardia.

>That's probably the disk IO scheduler.

Yeah, definitely. I'm following the other thread on 2.4.20-rmap15a and
the dl hack. Let's see if we -you really, I'm not yet contributing
anything- can make 2.4.20 work smoothly.


--=20
Javier Marcet <jmarcet@pobox.com>

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3rc7QACgkQx/ptJkB7frzV7gCdEn/qML5j09jRMRbj8jFya/GW
B7wAn1aTiP6TYkH7TG8rlI0XZpdjz0m8
=M2VA
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
