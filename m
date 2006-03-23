Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWCWVCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWCWVCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWCWVCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:02:45 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:39856 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161005AbWCWVCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:02:44 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Date: Fri, 24 Mar 2006 07:01:02 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200603232151.47346.ncunningham@cyclades.com> <200603232322.23852.ncunningham@cyclades.com> <4422A823.1020409@garzik.org>
In-Reply-To: <4422A823.1020409@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1987406.tYgic12oXG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603240701.06739.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1987406.tYgic12oXG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Thursday 23 March 2006 23:52, Jeff Garzik wrote:
> Nigel Cunningham wrote:
> > Hi.
> >
> > At the moment libata doesn't pass pm_message_t down ata_device_suspend.
> > This causes drives to be powered down when we just want a freeze,
> > causing unnecessary wear and tear. This patch gets pm_message_t passed
> > down so that it can be used to determine whether to power down the
> > drive.
> >
> > Prepared against git at the time of writing. Please apply.
> >
> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
>
> I'll put this into the queue for review.
>
> As the top of each source file requests, please CC
> linux-ide@vger.kernel.org and myself on libata changes.

Ok. Thanks.

Nigel

--nextPart1987406.tYgic12oXG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIwySN0y+n1M3mo0RAmUDAJ90pXB9Hun2vmJRYa7sAxqtMd8JuwCgnLnF
bJpAZobR15ZQT5TpY46oOOQ=
=Rd0R
-----END PGP SIGNATURE-----

--nextPart1987406.tYgic12oXG--
