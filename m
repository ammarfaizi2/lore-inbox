Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312355AbSCYIvX>; Mon, 25 Mar 2002 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312369AbSCYIvO>; Mon, 25 Mar 2002 03:51:14 -0500
Received: from ip68-6-164-6.sd.sd.cox.net ([68.6.164.6]:3993 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP
	id <S312355AbSCYIvD>; Mon, 25 Mar 2002 03:51:03 -0500
Date: Mon, 25 Mar 2002 00:50:53 -0800
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020325085053.GB1382@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 12:43:18PM +1100, Andre Pang wrote:
> Can somebody with a KT133/KT133A do a "lspci -n" and grep for
> '8305'?  If it doesn't appear, I'll send off my patch.

Sorry to disappoint you:

$ sudo lspci -n | grep 8305
00:01.0 Class 0604: 1106:8305

It's an Abit KT7A-RAID, which is a KT133A.

Having said that, I've been seeing odd video artifacts in xawtv windows
since the patch was expanded from merely clearing bit 7. :)

--=20
Marc Wilson
msw@cox.net
http://members.cox.net/msw


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8nuTtTDNDGg1Nl+sRAql8AKCpfme0SrFGHQC5n8L8tXy85OlmdQCfUokA
63p2yXVZuz7XTmQ+xOMmAqk=
=FT+v
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
