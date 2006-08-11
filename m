Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWHKNmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWHKNmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHKNmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:42:21 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:19741 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751115AbWHKNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:42:20 -0400
Date: Fri, 11 Aug 2006 15:42:15 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
Message-ID: <20060811134215.GA26017@hansmi.ch>
References: <20060811050310.958962036.dtor@insightbb.com> <20060811050611.530817371.dtor@insightbb.com> <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com> <1155302169.19959.16.camel@localhost.localdomain> <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <d120d5000608110634n501d33b0yb7702a24cbf064e3@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2006 at 09:34:44AM -0400, Dmitry Torokhov wrote:
> How about we add backlight_set_power(&bd, power) to the backlight core
> to take care of proper locking for drivers?

I've tried to add several functions to the backlight core
({s,g}et_{brightness,power}) and they were rejected. Thus all the
locking is spread over the drivers. I agree it's faulty right now.
It's still easier to move to backlight core functions than to fix all
the drivers.

Because I am responsible/wrote for the broken code, how should I
proceed?

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE3Ik36J0saEpRu+oRAsoiAJ0XjLDlev3bKuvm7aSiZvVbDjMr6gCeK7a0
FlIzZdK3l6y8UngH2ag9pYE=
=rf4q
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
