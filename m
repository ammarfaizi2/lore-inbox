Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVCXAUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVCXAUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVCXAUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:20:34 -0500
Received: from server8.totalchoicehosting.com ([216.180.241.250]:25290 "EHLO
	server8.totalchoicehosting.com") by vger.kernel.org with ESMTP
	id S261213AbVCXAUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:20:25 -0500
From: Michael Wu <flamingice@sourmilk.net>
To: netdev@oss.sgi.com
Subject: Re: 2.6.x wireless update and status
Date: Wed, 23 Mar 2005 19:20:07 -0500
User-Agent: KMail/1.7.1
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       "David S. Miller" <davem@davemloft.net>
References: <4240CA69.9020902@pobox.com> <20050323055243.GU8648@jm.kir.nu>
In-Reply-To: <20050323055243.GU8648@jm.kir.nu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3526203.1HYpb7u0Vr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503231920.13459.flamingice@sourmilk.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server8.totalchoicehosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sourmilk.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3526203.1HYpb7u0Vr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 23 March 2005 12:52 am, Jouni Malinen wrote:
> > Moving forward, the next "todo" for kernel wireless hackers is to get
> > ieee80211 common code lib into shape, namely:
> > * Merge Intel ipw drivers, which use ieee80211
> > * Update HostAP to use ieee80211
> > * Merge/convert other drivers to use ieee80211?
>
> I'll be working on HostAP driver next; and ieee80211 code of course at
> the same time, since it is likely to need some changes for this. As far
> as other drivers are concerned, I'd like to see Atheros cards working
> with the generic ieee80211 code. They would be a good test target since
> they are an example of design where very large part of functionality is
> in the driver/network stack (no firmware used). This would be a good
> test to verify that the 802.11 code is generic enough for such a design.
>
The ADM8211 would be a good test too. So far, the main thing I see missing=
=20
from the 802.11 code is software scanning/authentication/association. Is al=
l=20
of that being moved to userspace? I prefer having a little bit of that in t=
he=20
kernel so minimal managed, adhoc, and WEP features can be used without a=20
daemon.

=2DMichael Wu

--nextPart3526203.1HYpb7u0Vr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQge9yWWBbDEe0UIRAvEpAKCHHWAIal32i+WdBjp4QQUyfssbcgCdFgxq
PFsdsoGT8uaz7+GYBNSz0o8=
=qGSE
-----END PGP SIGNATURE-----

--nextPart3526203.1HYpb7u0Vr--
