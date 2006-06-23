Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWFWOgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWFWOgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFWOgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:36:46 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:20610 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750792AbWFWOgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:36:45 -0400
Subject: Re: [Alsa-devel] all-modular snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Collins <paul@briny.ondioline.org>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5h7j389c7d.wl%tiwai@suse.de>
References: <87hd2cz116.fsf@briny.internal.ondioline.org>
	 <1151072095.7608.29.camel@localhost>  <s5h7j389c7d.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BvOkEEGaCVOxmNY8zb4J"
Date: Fri, 23 Jun 2006 16:36:30 +0200
Message-Id: <1151073390.7608.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BvOkEEGaCVOxmNY8zb4J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 16:30 +0200, Takashi Iwai wrote:

> Where is the problem in Makefile?  It looks OK to me...

Well, the problem is the fact the snd-aoa/ dir contains nothing to be
compiled and the kernel Makefiles don't like that.

> Nevertheless, aoa/Kconfig has a wrong dependency on SND_PCM.

Good point. Committing to my repository, how should we process things
like that now? Should I post some patches once a while or do you want to
commit that right away?

johannes

--=-BvOkEEGaCVOxmNY8zb4J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJv8bKVg1VMiehFYAQK0LA//bdVVvIqMvjLvCx+hnzpQiM1PWmPweTVv
GbajoPjEOWatE3LXSFhdOnSXPY24H5gDbBaFrO9XnrASCOp/r9pVvtEqHpP8M9kb
o8tdt1AE/oEOpk/sdGgJHb/29nU502zlgBW3NaZDnh5H06aAhLSoeLO5q8rmmmEC
kNzQpzzmQzIAPYtyhUe3kFm5eYSAyDa2a3+Cj4uoTSejPqlyeJaw/bKdI9vO7IUG
+r+RMaM5xGUBZ7FgLn/TUWq237qmFTize0eiFJYcFWDU08SCgA28OmjYeih3J/EJ
ZU+fMIvtdp8/C9q4fbMOhZkj1og1Oa9wIcwD9qScnh/me/HwzcPyBLI3oQtfF1Hw
rJdn4K9PHYhIMRm9j42FQwfy4KSBpRGk32pMWvnEBKAY8iAjrYjeB3ErXzqRMXfR
TpREKQUzYENyp3gkJNI/ndQXXBCjYU4NnflbZPhSNhZdvL5hXyZqL6KsuriUy/3N
X2bh95DezDUj3DEvevN6CGiB6Uzk7dZuhAkQ+KgyKbRzWCqvkpl+RMXMVV/ZVsiK
5MMdAyWYvv6uYi0oi7PYKSfAyi4i9ZFD13LggDUb4QG7lwVGKqzBX0USMOJ2Fk0/
dB86LCK0P/q5I4DvNXUfwuuHH/UFtlcrCC3pheY8mYxtBuN1IA8jxRo+iA0T2lEr
tpV8ZZEClH8=
=OvP7
-----END PGP SIGNATURE-----

--=-BvOkEEGaCVOxmNY8zb4J--

