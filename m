Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTDWR1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTDWR1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:27:52 -0400
Received: from dracula.eas.gatech.edu ([130.207.67.209]:219 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S264151AbTDWR06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:26:58 -0400
Date: Wed, 23 Apr 2003 13:37:01 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5.68] [BUG #18] Add Synaptics touchpad tweaking to psmouse driver
Message-ID: <20030423173701.GB6618@shaftnet.org>
References: <20030422024628.GA8906@shaftnet.org> <20030423181339.A2904@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20030423181339.A2904@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2003 at 06:13:39PM +0100, Christoph Hellwig wrote:
> This is messy as hell - what about copying psmouse.c, remove all
> that code not relevant to the touchpad and make it a driver of it's
> own?

That's my plan.

Like I said, this was the first cut.  And it solves the immediate=20
problem.  The RightWay is to create a native synaptics driver, and I'm=20
working on that, but it will be a little ways off because it's radically=20
different.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
                                                           ICQ #1318444
Quidquid latine dictum sit, altum viditur                 Melbourne, FL

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+ps89PuLgii2759ARAgu4AJ9r4DenQb5ZqnzRlvPGbA+1JCkFsgCg3Ra5
fFTSemiDMxS3fF3Vg49oOho=
=Its2
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
