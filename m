Return-Path: <linux-kernel-owner+w=401wt.eu-S932098AbXAIT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXAIT25 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbXAIT25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:28:57 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:38686 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbXAIT24 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:28:56 -0500
Message-Id: <200701091927.l09JRJXM021563@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Mimi Zohar <zohar@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
In-Reply-To: Your message of "Mon, 08 Jan 2007 17:38:25 EST."
             <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168370839_17810P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Jan 2007 14:27:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168370839_17810P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Jan 2007 17:38:25 EST, Mimi Zohar said:

> revoked. Based on previous comments on lkml, we understand
> that this is not really possible in general, so SLIM only
> attempts to revoke access in certain simple cases.

Which, unfortunately, creates incredibly brittle code when some attacker
reads the SLIM source code and finds a way to force the non-simple case
you ignore.

This is an area where you really need to do it *right*, or not at all.

--==_Exmh_1168370839_17810P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFo+yXcC3lWbTT17ARAhA0AJ4uJL60Ecda2iyVSBGBKP7qFblerQCgqb4E
vk14vrHqBPH/rhx1CsR3L6g=
=tvSG
-----END PGP SIGNATURE-----

--==_Exmh_1168370839_17810P--
