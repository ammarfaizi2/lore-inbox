Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTFIASO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTFIASO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:18:14 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.45]:43394 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264094AbTFIASN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:18:13 -0400
Date: Sun, 08 Jun 2003 20:31:36 -0400
From: Jeff <jeffpc@optonline.net>
Subject: Re: Linksys WRT54G and the GPL
In-reply-to: <20030609001929.GA5259@magi.fakeroot.net>
To: linux-kernel@vger.kernel.org
Message-id: <200306082031.45573.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <000501c32e00$85d4f670$8200a8c0@coolermaster>
 <20030609001929.GA5259@magi.fakeroot.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Another product from Linksys that runs linux is "EtherFast® Network Attached 
Storage." The firmware contains an ext2 image with some i386 binaries. It 
appears to be running 2.4.14-xfs (I did not locate the kernel, but the 
network module has it as a version.)

This is what I did:

unzip efg80.zip
mv EFG80_V10R33.bin EFG80_V10R33.bin.tar.gz
tar -xzf EFG80_V10R33.bin.tar.gz
cd rpm
mv system.img system.img.gz
gzip -df system.img
mount system.img /mnt -t ext2 -o loop

Jeff.

P.S. I did not check every document Linksys has about this product.

- -- 
I have recently changed my GPG key from 0x68FA8E08 to 0xC7958FFE.
For more information see http://www.sweb.cz/supertucnak/gpg/

- --
FORTUNE PROVIDES QUESTIONS FOR THE GREAT ANSWERS: #19
A:      To be or not to be.
Q:      What is the square root of 4b^2?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+49VswFP0+seVj/4RAkuLAJ9T2qfgmCd2U7bYlLnQxKKZXHmFbwCgs4ls
U1rTKpeeiXUsxgT+N0Ixjhc=
=yUuw
-----END PGP SIGNATURE-----

