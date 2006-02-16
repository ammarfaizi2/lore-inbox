Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWBPUaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWBPUaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBPUaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:30:12 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:49899 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932353AbWBPUaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:30:11 -0500
Date: Thu, 16 Feb 2006 15:30:07 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: can't loadkeys anymore? (was Re: Linux-2.6.15.4 login errors)
Message-ID: <20060216203007.GB17970@butterfly.hjsoft.com>
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com> <20060216142824.GD13188@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20060216142824.GD13188@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2006 at 09:28:25AM -0500, Dave Jones wrote:
> On Thu, Feb 16, 2006 at 09:13:46AM -0500, linux-os (Dick Johnson) wrote:
>  > After installing linux-2.6.15.4, attempts to log in a non-root
>  > account gives these errors.
>  > Password:
>  > Last login: Thu Feb 16 08:53:20 on tty1
>  > Keymap 0: Permission denied
>  > Keymap 1: Permission denied
>  > Keymap 2: Permission denied
>  > LDSKBENT: Operation not permitted
>  > loadkeys: could not deallocate keymap 3
> It's coming from unicode_start
>  > This is a RH Fedora base. Anybody know how to turn this crap off?
> Apply updates.
> This was fixed in kbd 1.12-10.fc4.1

This still leaves the question: Why is loadkeys no longer permitted to
set the keymap for a tty the user currently owns?  What if the user
really does want to run loadkeys without having to be root (ie. to load
dvorak keymap)?

--=20
John M Flinchbaugh
john@hjsoft.com

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9ODPCGPRljI8080RAn3ZAKCSNitYYO5dFVNpLFlzeLPmPqGmJwCeOuho
h58Em4bOhlQOMnnUUREzyqM=
=SpQ5
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
