Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752102AbWCOAu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbWCOAu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWCOAu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:50:57 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52930 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1752102AbWCOAu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:50:56 -0500
Message-Id: <200603150050.k2F0ogpT019966@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Anshuman Gholap <anshu.pg@gmail.com>, linux-kernel@vger.kernel.org,
       Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [future of drivers?] a proposal for binary drivers. 
In-Reply-To: Your message of "Tue, 14 Mar 2006 00:06:48 +0100."
             <1142291208.8407.46.camel@gimli.at.home> 
From: Valdis.Kletnieks@vt.edu
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <200603081151.33349.jk-lkml@sci.fi> <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
            <1142291208.8407.46.camel@gimli.at.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142383841_9726P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 19:50:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1142383841_9726P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Mar 2006 00:06:48 +0100, Bernd Petrovitsch said:
> On Wed, 2006-03-08 at 15:33 +0530, Anshuman Gholap wrote:
> [...]
> > into installing it) , he knowing me as a linux person will keep
> > bugging me, when i tell him to install a kernel source compile it to
> > allow 16k stack, install ndiswrapper and load the windows driver and
> 
> And you seriously think that $COMPANY will rewrite their driver to work
> with 4K-stacks (which seems to me to be an absolute requirement ATM)?

>From the NVidia drivers changelog:

2004-6-30 version 1.0-6106

    * Added support for GLSL (OpenGL Shading Language).

    * Added support for GL_EXT_pixel_buffer_object.

    * Added support for 4kstack kernels.

Looks like they managed to do that quite some time ago - in fact, before
some parts of the *in-kernel* code were totally cleaned up....

So yes, I *do* expect $COMPANY to re-write their driver to support 4K stacks. ;)

--==_Exmh_1142383841_9726P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEF2ThcC3lWbTT17ARAjvtAKCaGDiu2gU1XU4TGnXA81yODIg3ZgCgjl/2
xQj8JNKZsks31xNeieC4+z4=
=VVUF
-----END PGP SIGNATURE-----

--==_Exmh_1142383841_9726P--
