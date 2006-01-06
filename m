Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWAFM0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWAFM0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWAFM0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:26:32 -0500
Received: from sipsolutions.net ([66.160.135.76]:61444 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750771AbWAFM0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:26:32 -0500
Subject: Re: State of the Union: Wireless
From: Johannes Berg <johannes@sipsolutions.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060106114620.GA23707@isilmar.linta.de>
References: <20060106042218.GA18974@havoc.gtf.org>
	 <1136547084.4037.41.camel@localhost>
	 <20060106114620.GA23707@isilmar.linta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pn4ZYF1I2OiS/FpE2WQN"
Date: Fri, 06 Jan 2006 13:26:24 +0100
Message-Id: <1136550384.4037.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pn4ZYF1I2OiS/FpE2WQN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> From someone who has no idea at all (yet) about 802.11: why character
> device, and not sysfs or configfs files? Like

As Michael already said -- there's no real reason for that. We were just
brainstorming. The /dev idea seemed like a good plan at first, but then
it isn't fixed. What you suggested below does look useful too.

Coming back to the point Michael already raised: the overarching idea is
to get rid of the net_dev for the 'master' device, even if the
underlying hardware supports only a single virtual device (which might
then be created by the driver automatically)

I'll move the wiki pages a bit to accomodate different models, please
check in a few minutes.

johannes

--=-pn4ZYF1I2OiS/FpE2WQN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ75h7qVg1VMiehFYAQJ9hRAAhS1iOJEYYhn1Mcm/D0N2EkAH99y7A3Fl
DJw0+37syAHVeyti+jntkCWVG1WEkawe6wMeh77deumRTc3fgonlTVKXRIpgVUMJ
lPbKpblVaSQrq26cjupuSBRCS5Hu6R2Lj2kFWrilGH9aa311G9Zs60I4rPlf8GG3
cETYSP8CsizXY17mrn+OUAHOT6fg2BOwJDsownEzI39vdYIc2JX/L6VD+uPkf1L9
Hn/Ga+qiZxG0wgWiHV883h4XLAOwwoHtnTk/iu/ONUss7PYaO9SMf+fJqUel1SFd
b5i2xQbKrWhWSIiUdNsPA1LPQhTAIcLrovEaiEVSV7uOtDsG5dPCszju2zDBRSAm
d5ZqUx3DDDzUcPwH0lpDNXFwvhVgNSCNZqv4qTiPH4PClEBqci4Lrs4DMzZFiTU1
btPEaJ2o7Zrw8y0QrIrd7RIvwGgin8M8Jz67Qv4M5CA8DEyTJZvSKCQcYQb1MweY
ovUTgmzgQN4GWFVvJsmbLFoKGuaTtRw9qRTX1d4R0eCSLA4pFV+xu3RagXQ/WzOL
VSPRSujxvuxQRqzWZlHM9R88j/ImSxKW5mk0MXGacUP8kPdT39XHG+IvYnQ3URvZ
wYUQa3cYUoiQ0qF9crxoS0Akn7P7xUf7j2hz341mw2kNfJpm3xjoXCTdM9KMIJkV
NYFId+sZJeU=
=ZGau
-----END PGP SIGNATURE-----

--=-pn4ZYF1I2OiS/FpE2WQN--

