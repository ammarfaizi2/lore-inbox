Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTKFQJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbTKFQJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:09:35 -0500
Received: from h80ad25a7.async.vt.edu ([128.173.37.167]:27024 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264018AbTKFQJd (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:09:33 -0500
Message-Id: <200311061606.hA6G6Jf4026228@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Marcel Lanz <marcel.lanz@ds9.ch>, linux-kernel@vger.kernel.org
Subject: Re: load 2.4.x binary only module on 2.6 
In-Reply-To: Your message of "Thu, 06 Nov 2003 15:58:15 GMT."
             <20031106155815.GQ7665@parcelfarce.linux.theplanet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20031106153004.GA30008@ds9.ch>
            <20031106155815.GQ7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-346720353P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Nov 2003 11:06:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-346720353P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Nov 2003 15:58:15 GMT, viro@parcelfarce.linux.theplanet.co.uk said:
> On Thu, Nov 06, 2003 at 04:30:04PM +0100, Marcel Lanz wrote:
> > I have a binary only module for 2.4.x.
> > How much work is it to write a kind of wrapper to load an "old" module
> > on 2.6 ?
> 
> Unfeasible.

http://www.minion.de for a counter-example.  Of course, the NVidia
driver was already built with a wrapper for the 2.4 kernel, so doing a
2.6 version wasn't too bad.

It's really going to depend on which kernel interfaces the module actually
uses, and what the module is doing.

--==_Exmh_-346720353P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qnFzcC3lWbTT17ARAuxTAKCXFyQLr2gJ8tHMZwjlCfJH0iDnHQCg7D8a
WvS0IF1BI9ys8Qshw6Z9rNY=
=fqNn
-----END PGP SIGNATURE-----

--==_Exmh_-346720353P--
