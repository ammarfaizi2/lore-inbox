Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUIANIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUIANIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUIANHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:07:52 -0400
Received: from frontend1.messagingengine.com ([66.111.4.30]:15768 "EHLO
	frontend1.messagingengine.com") by vger.kernel.org with ESMTP
	id S266485AbUIANHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:07:17 -0400
X-Sasl-enc: 5XoVMtsrZFWGSqhsOjzm+w 1094044036
Date: Wed, 01 Sep 2004 15:07:06 +0200
From: harry_b@mm.st
Reply-To: harry_b@mm.st
To: linux-kernel@vger.kernel.org
Subject: initrd missing TTY
Message-ID: <D41AD36206E266D4B00EBFCD@[192.168.1.247]>
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I am not sure where to ask this question but I hope this is the right place.

I am trying to setup an encrypted root partition where the key is stored 
gpg-encrypted on an USB memorystick. So far everything works quite nicely 
but I fail to get a TTY working in the initial RAM disk.

All I get is gpg complaining:
gpg: cannot open '/dev/tty': No such device or address

Any idea what's necessary to get a TTY within the RAM disk? Or is there any 
other way to pass a passphrase to gpg without displaying it on the screen?
(yes, I know about the --no-tty and --passphrase-fd options but when I use 
/dev/console the passphrase is visible)

Any ideas or hints?

TIA,
Harry

- --

1024D/40F14012 18F3 736A 4080 303C E61E  2E72 7E05 1F6E 40F1 4012

- -----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GIT/S dx s: a C++ ULS++++$ P+++ L+++$ !E W++ N+ o? K? !w !O !M
V PS+ PE Y? PGP+++ t+ 5-- X+ R+ !tv b++ DI++ D+ G e* h r++ y++
- ------END GEEK CODE BLOCK------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBNcmBfgUfbkDxQBIRAogjAJ9mZhb7zJ+g9EZpvOAwicrKaH8KnwCePw7S
ub5Y1xEeAqwTQTGFF3tgYt8=
=MUFf
-----END PGP SIGNATURE-----

