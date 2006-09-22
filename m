Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWIVLyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWIVLyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWIVLyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:54:51 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:27306 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932311AbWIVLyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:54:51 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH 2.6.18 1/1] net/ipv4: sysctl to allow non-superuser to bypass CAP_NET_BIND_SERVICE requirement
Date: Fri, 22 Sep 2006 13:55:06 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org>
In-Reply-To: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6041504.s87ZQnnRMP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609221355.10511.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6041504.s87ZQnnRMP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

William Pitcock wrote:
> This patch allows for a user to disable the requirement to meet the
> CAP_NET_BIND_SERVICE capability for a non-superuser. It is toggled by
> the net.ipv4.allow_lowport_bind_nonsuperuser sysctl value.

I assume you are searching for accessfs.

Eike

--nextPart6041504.s87ZQnnRMP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFE88eXKSJPmm5/E4RAvMbAJ9ZCVZ0JZB8dsP1LxVBeTifUuULtgCfXpQo
Viu+6ckcz5I0THQqeoV+nZE=
=PTRp
-----END PGP SIGNATURE-----

--nextPart6041504.s87ZQnnRMP--
