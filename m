Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280707AbRKJUOg>; Sat, 10 Nov 2001 15:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280708AbRKJUO0>; Sat, 10 Nov 2001 15:14:26 -0500
Received: from thor.hol.gr ([194.30.192.25]:58805 "HELO thor.hol.gr")
	by vger.kernel.org with SMTP id <S280707AbRKJUOM>;
	Sat, 10 Nov 2001 15:14:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Panagiotis Moustafellos <panxer@hol.gr>
Reply-To: panxer@hol.gr
To: linux-kernel@vger.kernel.org
Subject: Compile problem 2.4.14 
Date: Sat, 10 Nov 2001 22:15:00 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111022150000.00265@gryppas>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all!

I am really getting a hard time compiling the 2.4.14..
My current system has a 2.4.13 (by patching all the way
from 2.4.9), so I patched the sources, yes after make clean,
make menuconfig, and make dep ; make bzImage, I get this
message (during the compilation of vmlinux )

fs/fs.o: In function `dput':
fs/fs.o(.text+0x10ad5): undefined reference to `atomic_dec_and_lock'
make: *** [vmlinux] Error 1

Prior to this I was getting this problem, described in a
message on this mailing list, about

drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x40eb): undefined reference to 
`deactivate_page'
drivers/block/block.o(.text+0x4119): undefined reference to 
`deactivate_page'

which I solved with the instructions of 

http://marc.theaimsgroup.com/?l=linux-kernel&m=100533846016359&w=2

Could someone give me some instruction on what could be
the problem, and hopefully, how to fix it?
Thanks in advance

- --------
Panagiotis Moustafellos
(aka panXer)
- --------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE77YrNbGyRbxX5XdQRAmmyAKCXQwmvFIC9y8BURxOYwZkOG6bfQQCg0FEM
EjFT9OsAHaBTkYGsysjpHb0=
=f59Q
-----END PGP SIGNATURE-----
