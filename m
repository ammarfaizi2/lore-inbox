Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUFRUDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUFRUDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUFRUCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:02:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:38282 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266789AbUFRUCM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:02:12 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: DMA API issues
Date: Fri, 18 Jun 2004 22:02:06 +0200
User-Agent: KMail/1.6.2
Cc: Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, joshua@joshuawise.com
References: <1087582845.1752.107.camel@mulgrave> <40D340FB.3080309@hp.com> <1087587669.1752.147.camel@mulgrave>
In-Reply-To: <1087587669.1752.147.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406182202.13528.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Freitag, 18. Juni 2004 21:41 schrieb James Bottomley:
> Well, I thought it was something like that.  So the problem could be
> solved simply by rejigging ohci to export td_alloc and td_free as
> overrideable methods?

Unfortunately no. Usb_buffer_alloc() needs to know about the restriction,
too.

	Regards
		Oliver

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA00pDbuJ1a+1Sn8oRAoqjAKDVMBJCgjrysIZlQYdLDFCTEic6JgCfQ6t/
g4B4/fqQwvFNelxVo4sQO3o=
=q4nt
-----END PGP SIGNATURE-----
