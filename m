Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWBNJDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBNJDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBNJDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:03:16 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:59836 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932446AbWBNJDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:03:14 -0500
Date: Tue, 14 Feb 2006 11:02:53 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Alessandro Zummo <azummo-vger@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] RTC subsystem, class
Message-ID: <20060214090253.GA32597@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Alessandro Zummo <azummo-vger@towertech.it>,
	linux-kernel@vger.kernel.org
References: <20060213225416.865078000@towertech.it> <20060213225417.074551000@towertech.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20060213225417.074551000@towertech.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 13, 2006 at 11:54:17PM +0100, Alessandro Zummo wrote:
> --- linux-rtc.orig/drivers/Makefile	2006-02-13 19:34:35.000000000 +0100
> +++ linux-rtc/drivers/Makefile	2006-02-13 19:35:30.000000000 +0100
> @@ -56,6 +56,7 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
>  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
>  obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_I2O)		+= message/
> +obj-y				+= rtc/
>  obj-$(CONFIG_I2C)		+= i2c/
>  obj-$(CONFIG_W1)		+= w1/
>  obj-$(CONFIG_HWMON)		+= hwmon/

Why is this obj-y? obj-$(CONFIG_RTC_CLASS) perhaps?

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8Zy91K+teJFxZ9wRAjGZAKCEg84iJXMlhYy+4HWyE6PqFMLUbgCggRZQ
MY20b2JPPkk5+whk9D1jj64=
=Zw1U
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
