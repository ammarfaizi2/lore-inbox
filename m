Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUBXHJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 02:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUBXHJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 02:09:29 -0500
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:53511 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S262132AbUBXHJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 02:09:25 -0500
In-Reply-To: <20040223172921.GD25779@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E570230C730@exa-atlanta.se.lsil.com> <20040223172921.GD25779@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-39-515116060"
Message-Id: <5FF241F5-6698-11D8-B07A-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
From: Paul Wagland <paul@wagland.net>
Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug fix)
Date: Tue, 24 Feb 2004 08:09:23 +0100
To: Matthew Wilcox <willy@debian.org>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-39-515116060
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Feb 23, 2004, at 18:29, Matthew Wilcox wrote:

> On Mon, Feb 23, 2004 at 12:24:31PM -0500, Bagalkote, Sreenivas wrote:
>> Hello all,
>>
>> The following patch fixes a bug in megaraid driver version 2.10.1
>> where irq was erroneously being disabled.
>
> Could we have a later version than 2.00.3 in 2.6 please?

In an interesting twist of fate, that is exactly what I am currently 
working on planning, see the patches that I pushed through last week, 
according to my estimates, I am about 1/3 of the way through 
modernising the 2.6 driver. However, as of yet I have received no 
comment from LSI about the modifications to the drivers that I have 
made. I have received a response from Jeff Garzik that it appears that 
I am on the right track.

As a side issue, the comment in the 2.6 driver that says that it is 
2.00.3 is just plain wrong. Look at the driver  from 2.6 and the 2.00.3 
release, there are a lot of differences there! The problem is that the 
2.6 and 2.4 drivers diverged a little at some point in the past, and 
then quite a lot in 2.6.1, hence the reason for taking so long to 
forward port the changes.

Cheers,
Paul

--Apple-Mail-39-515116060
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAOvijtch0EvEFvxURAoXtAJ4gwvnc0baa4RnQ5jYNfKq+cmdJZgCgmHpX
v2IbGVM744BQg/mYlHjdrrU=
=bGon
-----END PGP SIGNATURE-----

--Apple-Mail-39-515116060--

