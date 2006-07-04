Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWGDSw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWGDSw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWGDSw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:52:57 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:52146 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932332AbWGDSw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:52:56 -0400
Subject: Re: [Alsa-devel] sound connector detection
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       linux-input <linux-input@atrey.karlin.mff.cuni.cz>,
       Richard Purdie <rpurdie@rpsys.net>, alsa-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <s5hmzbp2wlu.wl%tiwai@suse.de>
References: <1151671786.13412.6.camel@localhost>
	 <200607011609.59426.dtor@insightbb.com>
	 <1151933414.20701.38.camel@localhost>  <s5hmzbp2wlu.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SwCka3o3MfjEWj02/He+"
Date: Tue, 04 Jul 2006 20:51:55 +0200
Message-Id: <1152039115.1834.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SwCka3o3MfjEWj02/He+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-07-04 at 17:55 +0200, Takashi Iwai wrote:

> Such a control element doesn't have to be IFACE_MIXER if you want to
> hide.  You can use IFACE_CARD, for example, for a card-specific
> element but not belonging to the mixer component.

Oh. Good, I'll submit a patch to change that then so that it isn't
there. Someone's probably gonna lart me for it though because it isn't
visible any more ;)

> That's true.  OTOH, invoking a command at each time isn't always a
> good solution, depending on the event-frequency and heaviness.

Yeah, that's the downside of a hotplug type approach.

Well, I'm open for other suggestions. I just dislike the current state
of pushing events through the alsa control elements. Sorta feels wrong.

johannes

--=-SwCka3o3MfjEWj02/He+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKq4yKVg1VMiehFYAQK7zg//dp0/YhF/oTZnuYSviUjKtWDWaiBMGOLN
j64Y5snAhVsxK9mB2wLHRshquvA5Lh2A70RL3pPB29Oo6O0Cbo4E23N4+Wi2fX7Q
AjtgO/Ew5wXiNWty28aFc8AHmfIltAIz58GUzg5GpsamXUKnHkzyCsbaAErAvTX+
cj/2D4Dd+dbVNflKibpgUSBUtZ1Y4FyyPWOoCXo9X4Ztm0SsOjfLZ0smILvsk9Jw
tmLpSoi3MlyZP7J7X1obffh6+XeDK+PuVqw+kSRO2POVeDFuA3yheJxIMSKlnqua
VNdtuKwhHuCquPjdPeHxb98DO2GRbCM+zLNbJkze6x0cvQcTIBNgudR+LS/EuVZD
QiZVS6o0xMGzBL1d8Za7WprGWjIo29LoZWucYUMdBK9pzjRgF9jDJa8a7UK3OaZG
TZTDnuZ2Wg1c+entfV7o+JD8JgH6EpafgVRRhlseQXv9tL8eU2L10OaWxgO+gEqX
9rGcdztpZwgW7qVNaNLlwpjzBPmZld+Ehu73jaX6SplqVeCLpljHgaDBjw3IOQ/9
t5H4cMEe3kTaJJi0qL7vl6YPTjYCcpG1AQIDMNqbot0vJzoO48n1U2Gi4yhnpxKD
ZVH68x9ppdPZr2C0WGF/dgTrDKeZI07ZhRYiKevhJddobnmmTYQwbedbnWyJJCOl
iOfpvVNRWoA=
=nQ3H
-----END PGP SIGNATURE-----

--=-SwCka3o3MfjEWj02/He+--

