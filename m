Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbUBZHn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUBZHn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:43:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262718AbUBZHnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:43:21 -0500
Date: Thu, 26 Feb 2004 08:43:17 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al pha1
Message-ID: <20040226074317.GC32246@devserv.devel.redhat.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Wed, Feb 25, 2004 at 06:05:43PM -0500, Mukker, Atul wrote:
> All,
> 
> Thanks a lot for the valuable feedback. The general consensus is against a
> single driver for different class of controllers. This would put a strain on
> our applications, which expect all the controllers to be exported from
> single driver's private ioctl interface.
> 
> With multiple adapters, applications would need to open multiple handles.
> This would somewhat complicate things for them. But keeping in line with
> general expectations, we would fork the drivers for different class of
> controllers now.

How much private ioctls do you need actually ? I assume that for sending raw
commands you use SG_IO already...

BTW it would be really nice if the various raid controller drivers could
come up with a joint common IOCTL api since it seems every raid controller
driver right now has a largely overlapping but yet different set of ioctls.

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAPaOUxULwo51rQBIRAuD/AJ4w3cY3Kn9DD9zhBeDJXqxOVQIYUgCdFt1t
b7I7Noq/RjmuMcTrF9ZGtuo=
=2WZf
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
