Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbTAaNmJ>; Fri, 31 Jan 2003 08:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTAaNmJ>; Fri, 31 Jan 2003 08:42:09 -0500
Received: from atlas.inria.fr ([138.96.66.22]:19400 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S267007AbTAaNmI>;
	Fri, 31 Jan 2003 08:42:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Organization: SEMIR - INRIA Sophia Antipolis
To: linux-kernel@vger.kernel.org
Subject: any compressed filesystem suggestion ?
Date: Fri, 31 Jan 2003 14:51:32 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301311451.33231.Nicolas.Turro@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi, we plan to build an NFS archive of old unix close accounts, and we are 
looking for a compressed filesystem since size is more important than speed 
for us. Our requirements are :
1- this fs must run on hardware raid (DAC960  Mylex AcceleRAID)
2- the archives files will be read-only for users, but we (administrators) 
must be able to add files to the archives...

Any recomendations ?
squashfs doesn't qualify because of 2 ...
what about e2compress ? http://www.alizt.com/index.html
I've heard about block layer compression... is it applicable for us ? 
Thanks for your advice...

N. Turro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+On9lty/HpgyBIboRAmnpAJ9RDqRmxQzKHEZvl6O9UwDSyPbNSACgp98O
lzO7h9I+BJ2FqzrI9RsiEHg=
=tLMr
-----END PGP SIGNATURE-----
