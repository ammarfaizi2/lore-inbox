Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVCVElm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVCVElm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVCVEdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:33:13 -0500
Received: from h80ad2695.async.vt.edu ([128.173.38.149]:28426 "EHLO
	h80ad2695.async.vt.edu") by vger.kernel.org with ESMTP
	id S262476AbVCVEbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:31:36 -0500
Message-Id: <200503220431.j2M4VNKF015112@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Arjan van de Ven <arjanv@redhat.com>
Cc: jmerkey <jmerkey@utah-nac.org>, linux-kernel@vger.kernel.org
Subject: Re: clone() and pthread_create() segment fault in 2.4.29 
In-Reply-To: Your message of "Mon, 21 Mar 2005 20:07:21 +0100."
             <20050321190721.GA19194@devserv.devel.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <423F13EA.6050007@utah-nac.org> <1111431021.6952.73.camel@laptopd505.fenrus.org> <423F1852.3070902@utah-nac.org>
            <20050321190721.GA19194@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1111465881_5089P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Mar 2005 23:31:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1111465881_5089P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Mar 2005 20:07:21 +0100, Arjan van de Ven said:
> On Mon, Mar 21, 2005 at 11:54:10AM -0700, jmerkey wrote:

> > which 2.4 kernels will work properly on RH ES release 3, Taroon Update 4. 
> 
> Only kernels with NPTL in, which for 2.4 limits you to the RH supplied one.

Well, strictly speaking, it's all GPL'ed, so Jeff is certainly free to take
the .src.rpm of the RedHat kernel, use rpm2cpio to extract the NPTL patches
from it, and forward port it to the 2.4.NN of his choice...

However, unless you're *really* handy with patch and diff, it's probably
more productive to upgrade to RH EL release 4, which comes with a 2.6 kernel...

(Speaking as somebody with RHEL 3 boxes going to RHEL 4 soon, and boxes that
are 2.6-mm with Fedora patches on top.. both have their place in the greater
scheme of things..)

--==_Exmh_1111465881_5089P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCP5+ZcC3lWbTT17ARAjdZAJ9mTCbTme/rVM0ueUw414YpZdy5GwCg2txi
VbFpWL6bKtH50mZ5YVQuINY=
=LZ/T
-----END PGP SIGNATURE-----

--==_Exmh_1111465881_5089P--
